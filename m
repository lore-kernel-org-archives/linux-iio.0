Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48909 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343Ab3HVQgH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 22 Aug 2013 12:36:07 -0400
From: "Drubin, Daniel" <daniel.drubin@intel.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	"Yuniverg, Michael" <michael.yuniverg@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Haimovich, Yoav" <yoav.haimovich@intel.com>
Subject: RE: working with IIO
Date: Thu, 22 Aug 2013 16:35:36 +0000
Message-ID: <CE30B71206DDA24CBD6D43D23C236C034D8C7C@HASMSX103.ger.corp.intel.com>
References: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com>
 <a761c167-aef3-42a3-a4bd-fa5078861dd1@email.android.com>
 <CE30B71206DDA24CBD6D43D23C236C034D8B11@HASMSX103.ger.corp.intel.com>
 <52160F47.2030403@metafoo.de>
 <CE30B71206DDA24CBD6D43D23C236C034D8BAA@HASMSX103.ger.corp.intel.com>
 <52161D55.8090201@metafoo.de>
 <CE30B71206DDA24CBD6D43D23C236C034D8BDE@HASMSX103.ger.corp.intel.com>
 <521625C5.4020504@metafoo.de> <52162987.501@jic23.retrosnub.co.uk>
 <CE30B71206DDA24CBD6D43D23C236C034D8C22@HASMSX103.ger.corp.intel.com>
 <09a07412-809b-491d-8c90-55003f6bfbf9@email.android.com>
In-Reply-To: <09a07412-809b-491d-8c90-55003f6bfbf9@email.android.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Wy4uLl0NCj4gIE5vdCBmb3IgcmVwbGljYXRpbmcgdGhlDQo+ID5zYW1lIG1tYXAoKWVkIGRhdGEg
Zm9yIG11bHRpcGxlIGNsaWVudHMgb2YgY291cnNlLCBidXQgSUlSQyB5ZXMsIHY0bA0KPiA+YWxs
b3dzIG11bHRpcGxlIGNoYW5uZWxzIHRvIGJlIG9wZW5lZC4gRS5nLiBmb3IgcGVla2luZyBmdWxs
IHZpZGVvLA0KPiA+cHJldmlldyBhbmQgdGVsZXRleHQgb3IgZm9yIHN3aXRjaGluZyBiZXR3ZWVu
IHZpZGVvIHNvdXJjZXMgb24gdGhlIHNhbWUNCj4gPmdyYWJiZXIuIE1ha2luZyB0aGUgd2hvbGUg
bWFqb3Igbm9kZSBzaW5nbGV0b24gaXMgYSBiaXQgaGFyc2gNCj4gPnJlc3RyaWN0aW9uIElNSE8u
DQo+IFN1cmUgdG8gdGhhdCBidXQgaGVyZSBlcXVpdmFsZW50IGlzIG9wZW5pbmcgbWFpbiBzdHJl
YW0gYW4gcHVsbGluZyBvdXQNCj4gZGlmZmVyZW50IGZyYW1lIHJhdGVzLiBFcXVpdmFsZW50IG9m
IHlvdXIgZXhhbXBsZSBpcyBhIG11bHRpcGxlIHNhbXBsZSByYXRlDQo+IGhhcmR3YXJlIGRldmlj
ZS4gVGhvc2UgYXJlIGhhbmRsZWQgdXNpbmcgbXVsdGlwbGUgaW5zdGFuY2VzIG9mIGlpb19EZXYu
DQoNCldlIGFjdHVhbGx5IGNvbnNpZGVyZWQgY3JlYXRpbmcgYSBzZXBhcmF0ZSBpaW9fZGV2IHBl
ciAidmlydHVhbCIgc2Vuc29yIChwYWlyIG9mIHtzZW5zb3IsIHJhdGV9KS4gVGhlIHByb2JsZW0g
aXMsIHRoZXkgY2FuIHBvcC11cCBkeW5hbWljYWxseSBhbmQgZXZlbiBpZiB3ZSBvcGVuZWQgYSBi
YWNrZG9vciBpbnRlcmZhY2Ugb2Ygc2lsZW50bHkgY3JlYXRpbmcgbmV3IGNoYXJkZXZzLCB3ZSBj
YW4ndCBlYXQgdXAgYWxsIG1ham9yIG51bWJlcnMgaW4gdGhlIHN5c3RlbS4gQW5kIHdlIGNhbiBn
ZXQgZGFuZ2Vyb3VzbHkgY2xvc2UgdG8gdGhhdCA6LSgNCg0KQmVzdCByZWdhcmRzLA0KRGFuaWVs
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBJc3JhZWwgKDc0KSBMaW1pdGVkCgpUaGlzIGUtbWFpbCBh
bmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IK
dGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcgb3Ig
ZGlzdHJpYnV0aW9uCmJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQKcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFu
ZCBkZWxldGUgYWxsIGNvcGllcy4K

