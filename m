Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39994 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755022AbcIPWaX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Sep 2016 18:30:23 -0400
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "rrs@researchut.com" <rrs@researchut.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "hadess@hadess.net" <hadess@hadess.net>
Subject: Re: possible odd acceleration scaling
Date: Fri, 16 Sep 2016 22:30:20 +0000
Message-ID: <1474064901.26681.5.camel@intel.com>
References: <1473787814.8047.8.camel@researchut.com>
         <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
         <d275ff67-4335-a6f4-b60b-c4227a59b34c@kernel.org>
         <1473793566.6874.10.camel@linux.intel.com>
         <1473843953.23872.3.camel@researchut.com>
         <1473845312.23872.5.camel@researchut.com>
         <1473861009.9913.7.camel@researchut.com>
         <1473866880.35049.5.camel@linux.intel.com>
         <1473867872.6389.16.camel@hadess.net>
         <1473868832.9913.14.camel@researchut.com>
         <1474047781.32019.1.camel@linux.intel.com>
         <1474050391.18741.3.camel@researchut.com>
         <1474050918.3066.0.camel@researchut.com>
         <1474054303.20470.2.camel@linux.intel.com>
         <1474054833.20470.4.camel@intel.com> <1474060746.6389.38.camel@hadess.net>
In-Reply-To: <1474060746.6389.38.camel@hadess.net>
Content-Type: multipart/mixed;
        boundary="_002_1474064901266815camelintelcom_"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--_002_1474064901266815camelintelcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE238A3D74B0F340BEC523DF203708B7@intel.com>
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDE2LTA5LTE2IGF0IDIzOjE5ICswMjAwLCBCYXN0aWVuIE5vY2VyYSB3cm90ZToN
Cj4gT24gRnJpLCAyMDE2LTA5LTE2IGF0IDE5OjQwICswMDAwLCBQYW5kcnV2YWRhLCBTcmluaXZh
cyB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIDIwMTYtMDktMTYgYXQgMTI6MzEgLTA3MDAsIFNy
aW5pdmFzIFBhbmRydXZhZGEgd3JvdGU6DQo+ID4gT24gU2F0LCAyMDE2LTA5LTE3IGF0IDAwOjA1
ICswNTMwLCBSaXRlc2ggUmFqIFNhcnJhZiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBP
biBGcmksIDIwMTYtMDktMTYgYXQgMjM6NTYgKzA1MzAsIFJpdGVzaCBSYWogU2FycmFmIHdyb3Rl
Og0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJJ2xsIGFsc28gY29uZmly
bSBmb3IgNC43IHNvb24uDQo+ID4gPiANCj4gPiA+IFZlcmlmaWVkIG9uIDQuNyB0b28gYW5kIGl0
IGlzIGFsbCBnb29kLg0KPiA+IFRoYW5rcy4NCj4gPiBJIHdpbGwgc2VuZCBhIHB1bGwgcmVxdWVz
dCB3aXRoIHRoaXMgcGF0Y2guDQo+ID4gDQo+ID4gSGkgQmFzdGllbiwNCj4gPiANCj4gPiBNeSBv
cmlnaW5hbCBwdWxsIHJlcXVlc3QgZm9yIGlzc3VlICM5OSBhbHJlYWR5IGhhZCB0aGlzIGNoYW5n
ZS4NCj4gPiBTb21laG93DQo+ID4gd2hlbiBtZXJnZWQgdG8gbWFpbiwgdGhpcyBjaGFuZ2Ugd2Fz
IHJlbW92ZWQuDQo+ID4gTWF5IGJlIGp1c3QgcmV2ZXJ0IGFuZCBwdWxsIGFnYWluLg0KPiBJZiB5
b3UgY2FuIGV4cGxhaW4gdGhlIGNoYW5nZSwgSSdkIGJlIGFsbCBmb3IgaXQsIGJlY2F1c2UgSSBk
b24ndA0KPiB1bmRlcnN0YW5kIGl0Lg0KUGxlYXNlIGNoZWNrIHRoZSBhdHRhY2hlZCBwYXRjaCB3
aXRoIGNvbW1lbnRzLg0KDQpUaGFua3MsDQpTcmluaXZhcw==

--_002_1474064901266815camelintelcom_
Content-Type: text/x-patch; name="0001-Fix-sorting-of-channels.patch"
Content-Description: 0001-Fix-sorting-of-channels.patch
Content-Disposition: attachment;
	filename="0001-Fix-sorting-of-channels.patch"; size=1205;
	creation-date="Fri, 16 Sep 2016 22:30:20 GMT";
	modification-date="Fri, 16 Sep 2016 22:30:20 GMT"
Content-ID: <B17B53383E4B9842883AF4464A4F385B@intel.com>
Content-Transfer-Encoding: base64

RnJvbSA2NDA2ZDk1M2ZiNjVhODM4ZmU3NjBkODZhMGI2NjQxMjhhMzQzYTAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogRnJpLCAxNiBTZXAgMjAxNiAxMDozMTowMCAtMDcw
MApTdWJqZWN0OiBbUEFUQ0hdIEZpeCBzb3J0aW5nIG9mIGNoYW5uZWxzCgpBcyBwZXIgdGhlIGRv
Y3VtZW50YXRpb24gb2YgZ19wdHJfYXJyYXlfc29ydAoiTm90ZSB0aGF0IHRoZSBjb21wYXJpc29u
IGZ1bmN0aW9uIGZvciBnX3B0cl9hcnJheV9zb3J0KCkgZG9lc24ndCB0YWtlIHRoZQpwb2ludGVy
cyBmcm9tIHRoZSBhcnJheSBhcyBhcmd1bWVudHMsIGl0IHRha2VzIHBvaW50ZXJzIHRvIHRoZSBw
b2ludGVycyBpbgp0aGUgYXJyYXkiClNvIHRoZSBhcmd1bWVudHMgdG8gdGhlIGZ1bmN0aW9uCglj
b21wYXJlX2NoYW5uZWxfaW5kZXggKGdjb25zdHBvaW50ZXIgYSwgZ2NvbnN0cG9pbnRlciBiKQpu
ZWVkcyB0byBiZSBkZXJlZmVyZW5jZWQgdG8gZ2V0IHBvaW50ZXIgdG8gaWlvX2NoYW5uZWxfaW5m
by4KLS0tCiBzcmMvaWlvLWJ1ZmZlci11dGlscy5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9paW8tYnVm
ZmVyLXV0aWxzLmMgYi9zcmMvaWlvLWJ1ZmZlci11dGlscy5jCmluZGV4IDQ0MGE4YjcuLjBiMjRi
YWMgMTAwNjQ0Ci0tLSBhL3NyYy9paW8tYnVmZmVyLXV0aWxzLmMKKysrIGIvc3JjL2lpby1idWZm
ZXItdXRpbHMuYwpAQCAtMjAwLDggKzIwMCw4IEBAIGNoYW5uZWxfaW5mb19mcmVlIChpaW9fY2hh
bm5lbF9pbmZvICpjaSkKIHN0YXRpYyBpbnQKIGNvbXBhcmVfY2hhbm5lbF9pbmRleCAoZ2NvbnN0
cG9pbnRlciBhLCBnY29uc3Rwb2ludGVyIGIpCiB7Ci0JY29uc3QgaWlvX2NoYW5uZWxfaW5mbyAq
aW5mb18xID0gYTsKLQljb25zdCBpaW9fY2hhbm5lbF9pbmZvICppbmZvXzIgPSBiOworCWNvbnN0
IGlpb19jaGFubmVsX2luZm8gKmluZm9fMSA9ICooaWlvX2NoYW5uZWxfaW5mbyAqKikgYTsKKwlj
b25zdCBpaW9fY2hhbm5lbF9pbmZvICppbmZvXzIgPSAqKGlpb19jaGFubmVsX2luZm8gKiopIGI7
CiAKIAlyZXR1cm4gKGludCkgKGluZm9fMS0+aW5kZXggLSBpbmZvXzItPmluZGV4KTsKIH0KLS0g
CjIuNy40Cgo=

--_002_1474064901266815camelintelcom_--
