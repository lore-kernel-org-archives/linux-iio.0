Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19732 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751226AbdDFE6y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Apr 2017 00:58:54 -0400
From: "Song, Hongyan" <hongyan.song@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "rrs@researchut.com" <rrs@researchut.com>,
        linux-iio <linux-iio@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [STABLE REGRESSION] iio: hid-sensor-trigger: Change get poll
 value function order to avoid sensor properties losing after resume from S3
Date: Thu, 6 Apr 2017 04:58:50 +0000
Message-ID: <AE3E3DFA698D6144A7445C92D1D41E2F10BF7BCE@SHSMSX103.ccr.corp.intel.com>
References: <1491035833.10386.1.camel@researchut.com>
         <1491059661.30396.37.camel@linux.intel.com>
         <1491246858.17255.10.camel@researchut.com>
         <1491353080.3695.4.camel@linux.intel.com>
         <1491389519.7588.1.camel@researchut.com>
 <1491406549.9822.107.camel@linux.intel.com>
In-Reply-To: <1491406549.9822.107.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SGkgU3Jpbml2YXMsDQoJSSBoYXZlIGNoZWNrZWQgdGhlIHBhdGNoIGRvc2Ugbm90IG1lZXRzIG15
IHJlcXVpcmVtZW50IGZvciBJU0guDQpXaXRoIHRoaXMgcGF0Y2ggc2Vuc29yIHByb3BlcnRpZXMg
c3RpbGwgbG9zaW5nIGFmdGVyIHJlc3VtZSBmcm9tIFMzLg0KDQpCUg0KU29uZyBIb25neWFuDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIFtt
YWlsdG86c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb21dIA0KU2VudDogV2VkbmVz
ZGF5LCBBcHJpbCA1LCAyMDE3IDExOjM2IFBNDQpUbzogcnJzQHJlc2VhcmNodXQuY29tOyBTb25n
LCBIb25neWFuIDxob25neWFuLnNvbmdAaW50ZWwuY29tPjsgbGludXgtaWlvIDxsaW51eC1paW9A
dmdlci5rZXJuZWwub3JnPg0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbU1RBQkxFIFJFR1JFU1NJT05dIGlpbzog
aGlkLXNlbnNvci10cmlnZ2VyOiBDaGFuZ2UgZ2V0IHBvbGwgdmFsdWUgZnVuY3Rpb24gb3JkZXIg
dG8gYXZvaWQgc2Vuc29yIHByb3BlcnRpZXMgbG9zaW5nIGFmdGVyIHJlc3VtZSBmcm9tIFMzDQoN
CkhpIEhvbmd5YW4sDQoNCkNhbiB5b3UgY2hlY2sgaWYgdGhlIHBhdGNoIG1lZXRzIHlvdXIgcmVx
dWlyZW1lbnQvbmVlZHMgZm9yIElTSD8NCg0KVGhhbmtzLA0KU3Jpbml2YXMNCg0KT24gV2VkLCAy
MDE3LTA0LTA1IGF0IDE2OjIxICswNTMwLCBSaXRlc2ggUmFqIFNhcnJhZiB3cm90ZToNCj4gT24g
VHVlLCAyMDE3LTA0LTA0IGF0IDE3OjQ0IC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdyb3Rl
Og0KPiA+IA0KPiA+IEhpIFJpdGVzaCwNCj4gPiANCj4gPiBEb2VzIHRoZSBhdHRhY2hlZCBwYXRj
aCBoZWxwcz8NCj4gDQo+IFRoYW5rIHlvdSBTcmluaXZhcy4gSSB0ZXN0ZWQgeW91ciBwYXRjaCBv
biB0b3Agb2YgNC4xMC44IGFuZCBpdCBpcyANCj4gd29ya2luZyBwZXJmZWN0Lg0KPiANCj4gUml0
ZXNoDQo+IA0K
