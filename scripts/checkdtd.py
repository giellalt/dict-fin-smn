
### Corrected Python Script



import os
import re
from lxml import etree

# Path to the DTD file and XML directory
dtd_file_path = "../dtd/finsmn.dtd"  # Replace with the actual path to your DTD file
xml_dir_path = "../src"  # Replace with the actual path to your XML files directory

# Extract elements and attributes from the DTD file
def parse_dtd(dtd_path):
    elements = set()
    attributes = set()
    with open(dtd_path, 'r') as file:
        for line in file:
            # Match elements defined in the DTD
            element_match = re.match(r'<!ELEMENT\s+(\w+)', line)
            if element_match:
                elements.add(element_match.group(1))
            # Match attributes defined in the DTD
            attribute_match = re.match(r'<!ATTLIST\s+(\w+)\s+(\w+)', line)
            if attribute_match:
                attributes.add((attribute_match.group(1), attribute_match.group(2)))
    return elements, attributes

# Extract elements and attributes from XML files
def parse_xml_files(xml_dir):
    elements = set()
    attributes = set()
    for filename in os.listdir(xml_dir):
        if filename.endswith('finsmn.xml'):
            file_path = os.path.join(xml_dir, filename)
            tree = etree.parse(file_path)
            for elem in tree.iter():
                elements.add(elem.tag)
                for attr in elem.attrib:
                    attributes.add((elem.tag, attr))
    return elements, attributes

# Compare DTD and XML
def main():
    dtd_elements, dtd_attributes = parse_dtd(dtd_file_path)
    xml_elements, xml_attributes = parse_xml_files(xml_dir_path)

    # Find unused elements and attributes
    unused_elements = dtd_elements - xml_elements
    unused_attributes = dtd_attributes - xml_attributes

    # Print results
    print("Unused Elements:")
    for elem in unused_elements:
        print(f"  - {elem}")

    print("\nUnused Attributes:")
    for elem, attr in unused_attributes:
        print(f"  - Element: {elem}, Attribute: {attr}")

if __name__ == "__main__":
    main()


