{-# LANGUAGE QuasiQuotes #-}

-- This module is auto-generated. DO NOT EDIT IT MANUALLY.

module Chainweb.BlockHeader.Genesis.Testnet01Payload ( payloadBlock ) where

import Data.Text.Encoding (encodeUtf8)
import Data.Yaml (decodeThrow)

import NeatInterpolation (text)

import Chainweb.Payload (PayloadWithOutputs)
import Chainweb.Utils (fromJuste)

payloadBlock :: PayloadWithOutputs
payloadBlock = fromJuste $ decodeThrow $ encodeUtf8 [text|
transactions:
- - eyJoYXNoIjoiMHRWYjY2Wld0QTVLU3BtemhEODRMMHdVQ3VhVm5PZkdtZGR0bGxBSGQyNCIsInNpZ3MiOltdLCJjbWQiOiJ7XCJwYXlsb2FkXCI6e1wiZXhlY1wiOntcImRhdGFcIjpudWxsLFwiY29kZVwiOlwiKG1vZHVsZSBjb2luIEdPVkVSTkFOQ0VcXG5cXG4gIFxcXCInY29pbicgcmVwcmVzZW50cyB0aGUgS2FkZW5hIENvaW4gQ29udHJhY3QuXFxcIlxcblxcblxcbiAgOyAoaW1wbGVtZW50cyBjb2luLXNpZylcXG4gIDsgKGltcGxlbWVudHMgc3B2LXNpZylcXG5cXG4gIDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cXG4gIDsgU2NoZW1hcyBhbmQgVGFibGVzXFxuICA7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXFxuXFxuICAoZGVmc2NoZW1hIGNvaW4tc2NoZW1hXFxuICAgIGJhbGFuY2U6ZGVjaW1hbFxcbiAgICBndWFyZDpndWFyZFxcbiAgICApXFxuICAoZGVmdGFibGUgY29pbi10YWJsZTp7Y29pbi1zY2hlbWF9KVxcblxcbiAgKGRlZnNjaGVtYSBjcmVhdGVzLXNjaGVtYVxcbiAgICBleGlzdHM6c3RyaW5nXFxuICAgIClcXG4gIChkZWZ0YWJsZSBjcmVhdGVzLXRhYmxlOntjcmVhdGVzLXNjaGVtYX0pXFxuXFxuICA7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXFxuICA7IENhcGFiaWxpdGllc1xcbiAgOyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxcblxcbiAgKGRlZmNhcCBHT1ZFUk5BTkNFICgpIChlbmZvcmNlIGZhbHNlIFxcXCJ1cGdyYWRlIGRpc2FibGVkXFxcIikpXFxuXFxuICAoZGVmY2FwIFRSQU5TRkVSICgpXFxuICAgIFxcXCJBdXRvbm9tb3VzIGNhcGFiaWxpdHkgdG8gcHJvdGVjdCBkZWJpdCBhbmQgY3JlZGl0IGFjdGlvbnNcXFwiXFxuICAgIHRydWUpXFxuXFxuICAoZGVmY2FwIENPSU5CQVNFICgpXFxuICAgIFxcXCJNYWdpYyBjYXBhYmlsaXR5IHRvIHByb3RlY3QgbWluZXIgcmV3YXJkXFxcIlxcbiAgICB0cnVlKVxcblxcbiAgKGRlZmNhcCBGVU5EX1RYICgpXFxuICAgIFxcXCJNYWdpYyBjYXBhYmlsaXR5IHRvIGV4ZWN1dGUgZ2FzIHB1cmNoYXNlcyBhbmQgcmVkZW1wdGlvbnNcXFwiXFxuICAgIHRydWUpXFxuXFxuICAoZGVmY2FwIEFDQ09VTlRfR1VBUkQgKGFjY291bnQpXFxuICAgIFxcXCJMb29rdXAgYW5kIGVuZm9yY2UgZ3VhcmRzIGFzc29jaWF0ZWQgd2l0aCBhbiBhY2NvdW50XFxcIlxcbiAgICAod2l0aC1yZWFkIGNvaW4tdGFibGUgYWNjb3VudCB7IFxcXCJndWFyZFxcXCIgOj0gZyB9XFxuICAgICAgKGVuZm9yY2UtZ3VhcmQgZykpKVxcblxcbiAgKGRlZmNhcCBHT1ZFUk5BTkNFICgpXFxuICAgIChlbmZvcmNlIGZhbHNlIFxcXCJFbmZvcmNlIG5vbi11cGdyYWRlYWJpbGl0eSBleGNlcHQgaW4gdGhlIGNhc2Ugb2YgYSBoYXJkIGZvcmtcXFwiKSlcXG5cXG4gIDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cXG4gIDsgQ29pbiBDb250cmFjdFxcbiAgOyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxcblxcbiAgKGRlZnVuIGJ1eS1nYXM6c3RyaW5nIChzZW5kZXI6c3RyaW5nIHRvdGFsOmRlY2ltYWwpXFxuICAgIEBkb2MgXFxcIlRoaXMgZnVuY3Rpb24gZGVzY3JpYmVzIHRoZSBtYWluICdnYXMgYnV5JyBvcGVyYXRpb24uIEF0IHRoaXMgcG9pbnQgXFxcXFxcbiAgICBcXFxcTUlORVIgaGFzIGJlZW4gY2hvc2VuIGZyb20gdGhlIHBvb2wsIGFuZCB3aWxsIGJlIHZhbGlkYXRlZC4gVGhlIFNFTkRFUiAgIFxcXFxcXG4gICAgXFxcXG9mIHRoaXMgdHJhbnNhY3Rpb24gaGFzIHNwZWNpZmllZCBhIGdhcyBsaW1pdCBMSU1JVCAobWF4aW11bSBnYXMpIGZvciAgICBcXFxcXFxuICAgIFxcXFx0aGUgdHJhbnNhY3Rpb24sIGFuZCB0aGUgcHJpY2UgaXMgdGhlIHNwb3QgcHJpY2Ugb2YgZ2FzIGF0IHRoYXQgdGltZS4gICAgXFxcXFxcbiAgICBcXFxcVGhlIGdhcyBidXkgd2lsbCBiZSBleGVjdXRlZCBwcmlvciB0byBleGVjdXRpbmcgU0VOREVSJ3MgY29kZS5cXFwiXFxuXFxuICAgIEBtb2RlbCBbKHByb3BlcnR5ICg-IHRvdGFsIDAuMCkpXVxcblxcbiAgICAocmVxdWlyZS1jYXBhYmlsaXR5IChGVU5EX1RYKSlcXG4gICAgKHdpdGgtY2FwYWJpbGl0eSAoVFJBTlNGRVIpXFxuICAgICAgIChkZWJpdCBzZW5kZXIgdG90YWwpKVxcbiAgICApXFxuXFxuICAoZGVmdW4gcmVkZWVtLWdhczpzdHJpbmcgKG1pbmVyOnN0cmluZyBtaW5lci1ndWFyZDpndWFyZCBzZW5kZXI6c3RyaW5nIHRvdGFsOmRlY2ltYWwpXFxuICAgIEBkb2MgXFxcIlRoaXMgZnVuY3Rpb24gZGVzY3JpYmVzIHRoZSBtYWluICdyZWRlZW0gZ2FzJyBvcGVyYXRpb24uIEF0IHRoaXMgICAgXFxcXFxcbiAgICBcXFxccG9pbnQsIHRoZSBTRU5ERVIncyB0cmFuc2FjdGlvbiBoYXMgYmVlbiBleGVjdXRlZCwgYW5kIHRoZSBnYXMgdGhhdCAgICAgIFxcXFxcXG4gICAgXFxcXHdhcyBjaGFyZ2VkIGhhcyBiZWVuIGNhbGN1bGF0ZWQuIE1JTkVSIHdpbGwgYmUgY3JlZGl0ZWQgdGhlIGdhcyBjb3N0LCAgICBcXFxcXFxuICAgIFxcXFxhbmQgU0VOREVSIHdpbGwgcmVjZWl2ZSB0aGUgcmVtYWluZGVyIHVwIHRvIHRoZSBsaW1pdFxcXCJcXG5cXG4gICAgQG1vZGVsIFsocHJvcGVydHkgKD4gdG90YWwgMC4wKSldXFxuXFxuICAgIChyZXF1aXJlLWNhcGFiaWxpdHkgKEZVTkRfVFgpKVxcbiAgICAod2l0aC1jYXBhYmlsaXR5IChUUkFOU0ZFUilcXG4gICAgICAobGV0KiAoKGZlZSAocmVhZC1kZWNpbWFsIFxcXCJmZWVcXFwiKSlcXG4gICAgICAgICAgICAgKHJlZnVuZCAoLSB0b3RhbCBmZWUpKSlcXG4gICAgICAgIChlbmZvcmNlICg-PSByZWZ1bmQgMC4wKSBcXFwiZmVlIG11c3QgYmUgbGVzcyB0aGFuIG9yIGVxdWFsIHRvIHRvdGFsXFxcIilcXG5cXG5cXG4gICAgICAgIDsgZGlyZWN0bHkgdXBkYXRlIGluc3RlYWQgb2YgY3JlZGl0XFxuICAgICAgICAoaWYgKD4gcmVmdW5kIDAuMClcXG4gICAgICAgICAgKHdpdGgtcmVhZCBjb2luLXRhYmxlIHNlbmRlclxcbiAgICAgICAgICAgIHsgXFxcImJhbGFuY2VcXFwiIDo9IGJhbGFuY2UgfVxcbiAgICAgICAgICAgICh1cGRhdGUgY29pbi10YWJsZSBzZW5kZXJcXG4gICAgICAgICAgICAgIHsgXFxcImJhbGFuY2VcXFwiOiAoKyBiYWxhbmNlIHJlZnVuZCkgfSlcXG4gICAgICAgICAgICApXFxuICAgICAgICAgIFxcXCJub29wXFxcIilcXG4gICAgICAgIChjcmVkaXQgbWluZXIgbWluZXItZ3VhcmQgZmVlKVxcbiAgICAgICAgKSlcXG4gICAgKVxcblxcbiAgKGRlZnVuIGNyZWF0ZS1hY2NvdW50OnN0cmluZyAoYWNjb3VudDpzdHJpbmcgZ3VhcmQ6Z3VhcmQpXFxuICAgIEBkb2MgXFxcIkNyZWF0ZSBhbiBhY2NvdW50IGZvciBBQ0NPVU5ULCB3aXRoIEFDQ09VTlQgYXMgYSBmdW5jdGlvbiBvZiBHVUFSRFxcXCJcXG4gICAgKGluc2VydCBjb2luLXRhYmxlIGFjY291bnRcXG4gICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6IDAuMFxcbiAgICAgICwgXFxcImd1YXJkXFxcIiAgIDogZ3VhcmRcXG4gICAgICB9KVxcbiAgICApXFxuXFxuICAoZGVmdW4gYWNjb3VudC1iYWxhbmNlOmRlY2ltYWwgKGFjY291bnQ6c3RyaW5nKVxcbiAgICBAZG9jIFxcXCJRdWVyeSBhY2NvdW50IGJhbGFuY2UgZm9yIEFDQ09VTlRcXFwiXFxuICAgICh3aXRoLWNhcGFiaWxpdHkgKEFDQ09VTlRfR1VBUkQgYWNjb3VudClcXG4gICAgICAod2l0aC1yZWFkIGNvaW4tdGFibGUgYWNjb3VudFxcbiAgICAgICAgeyBcXFwiYmFsYW5jZVxcXCIgOj0gYmFsYW5jZSB9XFxuICAgICAgICBiYWxhbmNlXFxuICAgICAgICApKVxcbiAgICApXFxuXFxuICAoZGVmdW4gdHJhbnNmZXI6c3RyaW5nIChzZW5kZXI6c3RyaW5nIHJlY2VpdmVyOnN0cmluZyByZWNlaXZlci1ndWFyZDpndWFyZCBhbW91bnQ6ZGVjaW1hbClcXG4gICAgQGRvYyBcXFwiVHJhbnNmZXIgYmV0d2VlbiBhY2NvdW50cyBTRU5ERVIgYW5kIFJFQ0VJVkVSIG9uIHRoZSBzYW1lIGNoYWluLiAgICBcXFxcXFxuICAgIFxcXFxUaGlzIGZhaWxzIGlmIGJvdGggYWNjb3VudHMgZG8gbm90IGV4aXN0LiBDcmVhdGUtb24tdHJhbnNmZXIgY2FuIGJlICAgICAgXFxcXFxcbiAgICBcXFxcaGFuZGxlZCBieSBzZW5kaW5nIGluIGEgY3JlYXRlIGNvbW1hbmQgaW4gdGhlIHNhbWUgdHguXFxcIlxcblxcbiAgICBAbW9kZWwgWyhwcm9wZXJ0eSAoPiBhbW91bnQgMC4wKSldXFxuXFxuICAgICh3aXRoLWNhcGFiaWxpdHkgKFRSQU5TRkVSKVxcbiAgICAgIChkZWJpdCBzZW5kZXIgYW1vdW50KVxcbiAgICAgIChjcmVkaXQgcmVjZWl2ZXIgcmVjZWl2ZXItZ3VhcmQgYW1vdW50KSlcXG4gICAgKVxcblxcbiAgKGRlZnVuIGNvaW5iYXNlOnN0cmluZyAoYWRkcmVzczpzdHJpbmcgYWRkcmVzcy1ndWFyZDpndWFyZCBhbW91bnQ6ZGVjaW1hbClcXG4gICAgQGRvYyBcXFwiTWludCBzb21lIG51bWJlciBvZiB0b2tlbnMgYW5kIGFsbG9jYXRlIHRoZW0gdG8gc29tZSBhZGRyZXNzXFxcIlxcbiAgICAocmVxdWlyZS1jYXBhYmlsaXR5IChDT0lOQkFTRSkpXFxuICAgICh3aXRoLWNhcGFiaWxpdHkgKFRSQU5TRkVSKVxcbiAgICAgKGNyZWRpdCBhZGRyZXNzIGFkZHJlc3MtZ3VhcmQgYW1vdW50KSkpXFxuXFxuICAoZGVmcGFjdCBmdW5kLXR4IChzZW5kZXIgbWluZXIgbWluZXItZ3VhcmQgdG90YWwpXFxuICAgIEBkb2MgXFxcIidmdW5kLXR4JyBpcyBhIHNwZWNpYWwgcGFjdCB0byBmdW5kIGEgdHJhbnNhY3Rpb24gaW4gdHdvIHN0ZXBzLCAgICAgXFxcXFxcbiAgICBcXFxcd2l0aCB0aGUgYWN0dWFsIHRyYW5zYWN0aW9uIHRyYW5zcGlyaW5nIGluIHRoZSBtaWRkbGU6ICAgICAgICAgICAgICAgICAgIFxcXFxcXG4gICAgXFxcXCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXFxcXFxuICAgIFxcXFwgIDEpIEEgYnV5aW5nIHBoYXNlLCBkZWJpdGluZyB0aGUgc2VuZGVyIGZvciB0b3RhbCBnYXMgYW5kIGZlZSwgeWllbGRpbmcgXFxcXFxcbiAgICBcXFxcICAgICBUWF9NQVhfQ0hBUkdFLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcXFxcXG4gICAgXFxcXCAgMikgQSBzZXR0bGVtZW50IHBoYXNlLCByZXN1bWluZyBUWF9NQVhfQ0hBUkdFLCBhbmQgYWxsb2NhdGluZyB0byB0aGUgICBcXFxcXFxuICAgIFxcXFwgICAgIGNvaW5iYXNlIGFjY291bnQgZm9yIHVzZWQgZ2FzIGFuZCBmZWUsIGFuZCBzZW5kZXIgYWNjb3VudCBmb3IgYmFsLSAgXFxcXFxcbiAgICBcXFxcICAgICBhbmNlICh1bnVzZWQgZ2FzLCBpZiBhbnkpLlxcXCJcXG5cXG4gICAgKHN0ZXAgKGJ1eS1nYXMgc2VuZGVyIHRvdGFsKSlcXG4gICAgKHN0ZXAgKHJlZGVlbS1nYXMgbWluZXIgbWluZXItZ3VhcmQgc2VuZGVyIHRvdGFsKSlcXG4gICAgKVxcblxcbiAgOyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxcbiAgOyBIZWxwZXJzXFxuICA7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXFxuXFxuICAoZGVmdW4gZGViaXQ6c3RyaW5nIChhY2NvdW50OnN0cmluZyBhbW91bnQ6ZGVjaW1hbClcXG4gICAgQGRvYyBcXFwiRGViaXQgQU1PVU5UIGZyb20gQUNDT1VOVCBiYWxhbmNlIHJlY29yZGluZyBEQVRFIGFuZCBEQVRBXFxcIlxcblxcbiAgICBAbW9kZWwgWyhwcm9wZXJ0eSAoPiBhbW91bnQgMC4wKSldXFxuXFxuICAgIChyZXF1aXJlLWNhcGFiaWxpdHkgKFRSQU5TRkVSKSlcXG4gICAgKHdpdGgtY2FwYWJpbGl0eSAoQUNDT1VOVF9HVUFSRCBhY2NvdW50KVxcbiAgICAgICh3aXRoLXJlYWQgY29pbi10YWJsZSBhY2NvdW50XFxuICAgICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6PSBiYWxhbmNlIH1cXG5cXG4gICAgICAgIChlbmZvcmNlICg8PSBhbW91bnQgYmFsYW5jZSkgXFxcIkluc3VmZmljaWVudCBmdW5kc1xcXCIpXFxuICAgICAgICAodXBkYXRlIGNvaW4tdGFibGUgYWNjb3VudFxcbiAgICAgICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6ICgtIGJhbGFuY2UgYW1vdW50KSB9XFxuICAgICAgICAgICkpKVxcbiAgICApXFxuXFxuXFxuICAoZGVmdW4gY3JlZGl0OnN0cmluZyAoYWNjb3VudDpzdHJpbmcgZ3VhcmQ6Z3VhcmQgYW1vdW50OmRlY2ltYWwpXFxuICAgIEBkb2MgXFxcIkNyZWRpdCBBTU9VTlQgdG8gQUNDT1VOVCBiYWxhbmNlIHJlY29yZGluZyBEQVRFIGFuZCBEQVRBXFxcIlxcblxcbiAgICBAbW9kZWwgWyhwcm9wZXJ0eSAoPiBhbW91bnQgMC4wKSldXFxuXFxuICAgIChyZXF1aXJlLWNhcGFiaWxpdHkgKFRSQU5TRkVSKSlcXG4gICAgICAod2l0aC1kZWZhdWx0LXJlYWQgY29pbi10YWJsZSBhY2NvdW50XFxuICAgICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6IDAuMCwgXFxcImd1YXJkXFxcIiA6IGd1YXJkIH1cXG4gICAgICAgIHsgXFxcImJhbGFuY2VcXFwiIDo9IGJhbGFuY2UsIFxcXCJndWFyZFxcXCIgOj0gcmV0ZyB9XFxuICAgICAgICAgIDsgd2UgZG9uJ3Qgd2FudCB0byBvdmVyd3JpdGUgYW4gZXhpc3RpbmcgZ3VhcmQgd2l0aCB0aGUgdXNlci1zdXBwbGllZCBvbmVcXG4gICAgICAgIChlbmZvcmNlICg9IHJldGcgZ3VhcmQpIFxcXCJhY2NvdW50IGd1YXJkcyBkbyBub3QgbWF0Y2hcXFwiKVxcblxcbiAgICAgICAgKHdyaXRlIGNvaW4tdGFibGUgYWNjb3VudFxcbiAgICAgICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6ICgrIGJhbGFuY2UgYW1vdW50KVxcbiAgICAgICAgICAsIFxcXCJndWFyZFxcXCIgICA6IHJldGdcXG4gICAgICAgICAgfSkpXFxuICAgICAgKVxcblxcbiAgKGRlZnVuIGRlbGV0ZS1jb2luIChkZWxldGUtYWNjb3VudCBjcmVhdGUtY2hhaW4taWQgY3JlYXRlLWFjY291bnQgY3JlYXRlLWFjY291bnQtZ3VhcmQgcXVhbnRpdHkpXFxuICAgICh3aXRoLWNhcGFiaWxpdHkgKFRSQU5TRkVSKVxcbiAgICAgIChkZWJpdCBkZWxldGUtYWNjb3VudCBxdWFudGl0eSlcXG4gICAgICB7IFxcXCJjcmVhdGUtY2hhaW4taWRcXFwiOiBjcmVhdGUtY2hhaW4taWRcXG4gICAgICAsIFxcXCJjcmVhdGUtYWNjb3VudFxcXCI6IGNyZWF0ZS1hY2NvdW50XFxuICAgICAgLCBcXFwiY3JlYXRlLWFjY291bnQtZ3VhcmRcXFwiOiBjcmVhdGUtYWNjb3VudC1ndWFyZFxcbiAgICAgICwgXFxcInF1YW50aXR5XFxcIjogcXVhbnRpdHlcXG4gICAgICAsIFxcXCJkZWxldGUtY2hhaW4taWRcXFwiOiAoYXQgXFxcImNoYWluLWlkXFxcIiAoY2hhaW4tZGF0YSkpXFxuICAgICAgLCBcXFwiZGVsZXRlLWFjY291bnRcXFwiOiBkZWxldGUtYWNjb3VudFxcbiAgICAgICwgXFxcImRlbGV0ZS10eC1oYXNoXFxcIjogKHR4LWhhc2gpXFxuICAgICAgfSkpXFxuXFxuICAoZGVmdW4gY3JlYXRlLWNvaW4gKHByb29mKVxcbiAgICAobGV0ICgob3V0cHV0cyAoYXQgXFxcIm91dHB1dHNcXFwiICh2ZXJpZnktc3B2IFxcXCJUWE9VVFxcXCIgcHJvb2YpKSkpXFxuICAgICAgKGVuZm9yY2UgKD0gMSAobGVuZ3RoIG91dHB1dHMpKSBcXFwib25seSBvbmUgdHggaW4gb3V0cHV0c1xcXCIpXFxuICAgICAgKGJpbmQgKGF0IDAgb3V0cHV0cylcXG4gICAgICAgIHsgXFxcImNyZWF0ZS1jaGFpbi1pZFxcXCI6PSBjcmVhdGUtY2hhaW4taWRcXG4gICAgICAgICwgXFxcImNyZWF0ZS1hY2NvdW50XFxcIiA6PSBjcmVhdGUtYWNjb3VudFxcbiAgICAgICAgLCBcXFwiY3JlYXRlLWFjY291bnQtZ3VhcmRcXFwiIDo9IGNyZWF0ZS1hY2NvdW50LWd1YXJkXFxuICAgICAgICAsIFxcXCJxdWFudGl0eVxcXCIgOj0gcXVhbnRpdHlcXG4gICAgICAgICwgXFxcImRlbGV0ZS10eC1oYXNoXFxcIiA6PSBkZWxldGUtdHgtaGFzaFxcbiAgICAgICAgLCBcXFwiZGVsZXRlLWNoYWluLWlkXFxcIiA6PSBkZWxldGUtY2hhaW4taWRcXG4gICAgICAgIH1cXG4gICAgICAgIChlbmZvcmNlICg9IChhdCBcXFwiY2hhaW4taWRcXFwiIChjaGFpbi1kYXRhKSkgY3JlYXRlLWNoYWluLWlkIFxcXCJlbmZvcmNlIGNvcnJlY3QgY3JlYXRlIGNoYWluIElEXFxcIikpXFxuICAgICAgICAobGV0ICgoY3JlYXRlLWlkIChmb3JtYXQgXFxcIiU6JVxcXCIgW2RlbGV0ZS10eC1oYXNoIGRlbGV0ZS1jaGFpbi1pZF0pKSlcXG4gICAgICAgICAgKHdpdGgtZGVmYXVsdC1yZWFkIGNyZWF0ZS1pZCBjcmVhdGVzLXRhYmxlXFxuICAgICAgICAgICAgeyBcXFwiZXhpc3RzXFxcIjogZmFsc2UgfVxcbiAgICAgICAgICAgIHsgXFxcImV4aXN0c1xcXCI6PSBleGlzdHMgfVxcbiAgICAgICAgICAgIChlbmZvcmNlIChub3QgZXhpc3RzKSAoZm9ybWF0IFxcXCJlbmZvcmNlIHVuaXF1ZSB1c2FnZSBvZiAlXFxcIiBbY3JlYXRlLWlkXSkpXFxuICAgICAgICAgICAgKGluc2VydCBjcmVhdGVzLXRhYmxlIGNyZWF0ZS1pZCB7IFxcXCJleGlzdHNcXFwiOiB0cnVlIH0pXFxuICAgICAgICAgICAgKHdpdGgtY2FwYWJpbGl0eSAoVFJBTlNGRVIpXFxuICAgICAgICAgICAgICAoY3JlZGl0IGNyZWF0ZS1hY2NvdW50IGNyZWF0ZS1hY2NvdW50LWd1YXJkIHF1YW50aXR5KSkpXFxuICAgICAgICAgICkpKVxcbiAgICApXFxuXFxuXFxuKVxcblxcbihjcmVhdGUtdGFibGUgY29pbi10YWJsZSlcXG4oY3JlYXRlLXRhYmxlIGNyZWF0ZXMtdGFibGUpXFxuXCJ9fSxcInNpZ25lcnNcIjpbXSxcIm1ldGFcIjp7XCJnYXNMaW1pdFwiOjAsXCJjaGFpbklkXCI6XCJcIixcImdhc1ByaWNlXCI6MCxcInNlbmRlclwiOlwiXCJ9LFwibm9uY2VcIjpcIlxcXCJnZW5lc2lzLTAxXFxcIlwifSJ9
  - eyJobFR4TG9ncyI6ImNJM3Bib0YzZENqLXMtQVVxWVMwWTBHc1FlQ1dvVExfdHpGTjAwT1Z0Vm8iLCJobENvbW1hbmRSZXN1bHQiOnsic3RhdHVzIjoic3VjY2VzcyIsImRhdGEiOnsiaSI6bnVsbCwibGl0IjoiVGFibGVDcmVhdGVkIn19fQ
- - eyJoYXNoIjoiUEoyb1NsaEJBVUtnU1ViaFFxY2RFNVBRa1lCNDkzSlVwZnNLYU54cmhjayIsInNpZ3MiOltdLCJjbWQiOiJ7XCJwYXlsb2FkXCI6e1wiZXhlY1wiOntcImRhdGFcIjp7XCJzZW5kZXIwN1wiOltcIjRjMzFkYzllZTdmMjQxNzdmNzhiNmY1MTgwMTJhMjA4MzI2ZTJhZjFmMzdiYjBhMjQwNWI1MDU2ZDBjYWQ2MjhcIl0sXCJzZW5kZXIwMVwiOltcIjZiZTJmNDg1YTdhZjc1ZmVkYjRiN2YxNTNhOTAzZjdlNjAwMGNhNGFhNTAxMTc5YzkxYTI0NTBiNzc3YmQyYTdcIl0sXCJzZW5kZXIwNlwiOltcIjVmZmMxZjdmZWY3YTQ0NzM4NjI1NzYyZjc1YTQyMjk0NTQ5NTFlMDNmMmFmYzZmODEzMDljMGMxYmRmOWVlNmZcIl0sXCJzZW5kZXIwMFwiOltcIjM2ODgyMGY4MGMzMjRiYmM3YzJiMDYxMDY4OGE3ZGE0M2UzOWY5MWQxMTg3MzI2NzFjZDljNzUwMGZmNDNjY2FcIl0sXCJzZW5kZXIwNVwiOltcImYwOWQ4ZjYzOTRhZWE0MjVmZTY3ODNkODhjZDgxMzYzZDgwMTdmMTZhZmQzNzExYzU3NWJlMGY1Y2Q1YzliYjlcIl0sXCJzZW5kZXIwNFwiOltcIjJkNzBhYTRmNjk3YzNhM2I4ZGQ2ZDk3NzQ1YWMwNzRlZGNmZDBlYjY1YzM3Nzc0Y2RlMjUxMzU0ODNiZWE3MWVcIl0sXCJtdWx0aS0wMi0wMy0wNC1hbnlcIjp7XCJwcmVkXCI6XCJrZXlzLWFueVwiLFwia2V5c1wiOltcIjNhOWRkNTMyZDczZGFjZTE5NWRiYjY0ZDFkYmE2NTcyZmI3ODNkMGZkZDMyNDY4NWUzMmZiZGEyZjg5Zjk5YTZcIixcIjQzZjJhZGIxZGUxOTIwMDBjYjM3NzdiYWNjN2Y5ODNiNjYxNGZkOWMxNzE1Y2Q0NGNkNDg0YjZkM2EwZDM0YzhcIixcIjJkNzBhYTRmNjk3YzNhM2I4ZGQ2ZDk3NzQ1YWMwNzRlZGNmZDBlYjY1YzM3Nzc0Y2RlMjUxMzU0ODNiZWE3MWVcIl19LFwic2VuZGVyMDlcIjpbXCJjNTlkOTg0MGIwYjY2MDkwODM2NTQ2YjdlYjRhNzM2MDYyNTc1MjdlYzhjMmI0ODIzMDBmZDIyOTI2NGIwN2U2XCJdLFwic2VuZGVyMDNcIjpbXCI0M2YyYWRiMWRlMTkyMDAwY2IzNzc3YmFjYzdmOTgzYjY2MTRmZDljMTcxNWNkNDRjZDQ4NGI2ZDNhMGQzNGM4XCJdLFwibXVsdGktMDAtMDFcIjpbXCIzNjg4MjBmODBjMzI0YmJjN2MyYjA2MTA2ODhhN2RhNDNlMzlmOTFkMTE4NzMyNjcxY2Q5Yzc1MDBmZjQzY2NhXCIsXCI2YmUyZjQ4NWE3YWY3NWZlZGI0YjdmMTUzYTkwM2Y3ZTYwMDBjYTRhYTUwMTE3OWM5MWEyNDUwYjc3N2JkMmE3XCJdLFwic2VuZGVyMDhcIjpbXCI2M2IyZWJhNGVkNzBkNDYxMmQzZTdiYzkwZGIyZmJmNGM3NmY3YjA3NDM2M2U4NmQ3M2YwYmM2MTdmOGU4YjgxXCJdLFwic2VuZGVyMDJcIjpbXCIzYTlkZDUzMmQ3M2RhY2UxOTVkYmI2NGQxZGJhNjU3MmZiNzgzZDBmZGQzMjQ2ODVlMzJmYmRhMmY4OWY5OWE2XCJdfSxcImNvZGVcIjpcIihjb2luLmNvaW5iYXNlIFxcXCJzZW5kZXIwMFxcXCIgKHJlYWQta2V5c2V0IFxcXCJzZW5kZXIwMFxcXCIpIDEwMDAuMClcXG4oY29pbi5jb2luYmFzZSBcXFwic2VuZGVyMDFcXFwiIChyZWFkLWtleXNldCBcXFwic2VuZGVyMDFcXFwiKSAxMDEwLjApXFxuKGNvaW4uY29pbmJhc2UgXFxcInNlbmRlcjAyXFxcIiAocmVhZC1rZXlzZXQgXFxcInNlbmRlcjAyXFxcIikgMTAyMC4wKVxcbihjb2luLmNvaW5iYXNlIFxcXCJzZW5kZXIwM1xcXCIgKHJlYWQta2V5c2V0IFxcXCJzZW5kZXIwM1xcXCIpIDEwMzAuMClcXG4oY29pbi5jb2luYmFzZSBcXFwic2VuZGVyMDRcXFwiIChyZWFkLWtleXNldCBcXFwic2VuZGVyMDRcXFwiKSAxMDQwLjApXFxuKGNvaW4uY29pbmJhc2UgXFxcInNlbmRlcjA1XFxcIiAocmVhZC1rZXlzZXQgXFxcInNlbmRlcjA1XFxcIikgMTA1MC4wKVxcbihjb2luLmNvaW5iYXNlIFxcXCJzZW5kZXIwNlxcXCIgKHJlYWQta2V5c2V0IFxcXCJzZW5kZXIwNlxcXCIpIDEwNjAuMClcXG4oY29pbi5jb2luYmFzZSBcXFwic2VuZGVyMDdcXFwiIChyZWFkLWtleXNldCBcXFwic2VuZGVyMDdcXFwiKSAxMDcwLjApXFxuKGNvaW4uY29pbmJhc2UgXFxcInNlbmRlcjA4XFxcIiAocmVhZC1rZXlzZXQgXFxcInNlbmRlcjA4XFxcIikgMTA4MC4wKVxcbihjb2luLmNvaW5iYXNlIFxcXCJzZW5kZXIwOVxcXCIgKHJlYWQta2V5c2V0IFxcXCJzZW5kZXIwOVxcXCIpIDEwOTAuMClcXG4oY29pbi5jb2luYmFzZSBcXFwibXVsdGktMDAtMDFcXFwiIChyZWFkLWtleXNldCBcXFwibXVsdGktMDAtMDFcXFwiKSAxMDAxLjApXFxuKGNvaW4uY29pbmJhc2UgXFxcIm11bHRpLTAyLTAzLTA0LWFueVxcXCIgKHJlYWQta2V5c2V0IFxcXCJtdWx0aS0wMi0wMy0wNC1hbnlcXFwiKSAxMjM0LjApXCJ9fSxcInNpZ25lcnNcIjpbXSxcIm1ldGFcIjp7XCJnYXNMaW1pdFwiOjAsXCJjaGFpbklkXCI6XCJcIixcImdhc1ByaWNlXCI6MCxcInNlbmRlclwiOlwiXCJ9LFwibm9uY2VcIjpcIlxcXCJ0ZXN0bmV0MDAtZ3JhbnRzXFxcIlwifSJ9
  - eyJobFR4TG9ncyI6Ik0tY2tlN29DS1QzelIxMGRHUEFKR2doZ1dVTkJmS096emVJLUN6WDd1bEUiLCJobENvbW1hbmRSZXN1bHQiOnsic3RhdHVzIjoic3VjY2VzcyIsImRhdGEiOnsiaSI6bnVsbCwibGl0IjoiV3JpdGUgc3VjY2VlZGVkIn19fQ
minerData: eyJtIjoiTm9NaW5lciIsImtzIjpbXSwia3AiOiI8In0
transactionsHash: FCi4sC7UHplGWySke-iTrpVxVKD1zsB2VlGzHeyWS60
outputsHash: HAbXAS2QJOSs9V3-zbhwrJBvVh4-NQt21eUzGYfNN2c
payloadHash: 4XjRXYDS2e2LnkmIcS6Wd9rOsIJgjVpsPjIeGEej4mg
coinbase: eyJmbENvbW1hbmRSZXN1bHQiOnsic3RhdHVzIjoic3VjY2VzcyIsImRhdGEiOnsiaSI6bnVsbCwibGl0IjoiTk9fQ09JTkJBU0UifX0sImZsVHhMb2dzIjpbXX0

|]