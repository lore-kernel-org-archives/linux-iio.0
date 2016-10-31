Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:8655 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752930AbcJaAcU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Oct 2016 20:32:20 -0400
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: orientation: hid-sensor-rotation: Add PM function
Date: Mon, 31 Oct 2016 00:32:18 +0000
Message-ID: <1477873760.8025.46.camel@intel.com>
References: <1477357563-16794-1-git-send-email-hongyan.song@intel.com>
         <5c8d5490-93c9-a8c8-2d25-dbec3e2dc86f@kernel.org>
In-Reply-To: <5c8d5490-93c9-a8c8-2d25-dbec3e2dc86f@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE2LTEwLTMwIGF0IDE2OjIyICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiAyNS8xMC8xNiAwMjowNiwgU29uZyBIb25neWFuIHdyb3RlOg0KPiA+IA0KPiA+IFJv
dGF0aW9uIHNlbnNvciBmdW5jdGlvbiBkb2VzIG5vdCB3b3JrIGR1ZSB0byBtaXNzIFBNIGZ1bmN0
aW9uLg0KPiA+IEFkZCBjb21tb24gaGlkIHNlbnNvciBpaW8gcG0gZnVuY3Rpb24gZm9yIHJvdGF0
aW9uIHNlbnNvci4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTb25nIEhvbmd5YW4gPGhvbmd5
YW4uc29uZ0BpbnRlbC5jb20+DQoNCkZpeGVzOiAyYjg5NjM1ZTlhOWUgKCJpaW86IGhpZF9zZW5z
b3JfaHViOiBDb21tb24gUE0gZnVuY3Rpb25zIikNCg0KPiBEb2VzIHRoaXMgY29tcGxldGVseSBw
cmV2ZW50IHRoZSBkcml2ZXIgd29ya2luZyBvciBtZXJlbHkgbWFrZSBpdA0KPiBjb25zdW1lDQo+
IHRvbyBtdWNoIHBvd2VyPw0KSWYgQ09ORklHX1BNIGlzIG5vdCBkZWZpbmVkLCB0aGVuIHRoaXMg
cHJldmVudHMgdGhpcyBzZW5zb3IgdG8NCmZ1bmN0aW9uLiBTbyBhYm92ZSBjb21taXQgY2F1c2Vk
IHRoaXMuDQoNClRoaXMgc2Vuc29yIHdhcyBzdXBwb3NlZCB0byBiZSBhbHdheXMgb24gdG8gdHJp
Z2dlciB3YWtlIHVwIGluIHByaW9yDQpleHRlcm5hbCBodWJzLiBCdXQgd2l0aCB0aGUgbmV3IElT
SCBodWIgdGhpcyBpcyBub3QgdGhlIGNhc2UuDQo+IA0KPiBPbmx5IHJlYWxseSBtYWtlcyBhIGRp
ZmZlcmVuY2UgdG8gd2hpY2ggcm91dGUgaXQgdGFrZXMgdG8gbWFpbmxpbmUNCj4gYW5kIGhvdw0K
PiBmYXN0IGl0IGdldHMgdGhlcmUhDQpJZiBwb3NzaWJsZSBwdXNoIHRvIDQuOSBhbmQgbWFyayB0
byBzdGFibGUuDQoNClRoYW5rcywNClNyaW5pdmFzDQo=
