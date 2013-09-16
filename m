Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:35455 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753283Ab3IPKYE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 06:24:04 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 16 Sep 2013 12:23:33 +0200
Subject: Re: [PATCH 32/38] iio: accel-core: st: Move LSM303DLH into correct
 group
Message-ID: <5236DC25.3060909@st.com>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-33-git-send-email-lee.jones@linaro.org>
 <5234A20F.7040008@kernel.org> <20130916080546.GC3999@lee--X1>
 <5236CD17.5010901@st.com> <20130916093812.GG3999@lee--X1>
 <5236D5F0.2030601@st.com> <20130916101925.GJ3999@lee--X1>
In-Reply-To: <20130916101925.GJ3999@lee--X1>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Pj4gSSd2ZSB0cmllZCB3aXRoIHJlYWwgZGV2aWNlLi4uVW5mb3J0dW5hdGVseSwgeW91IGFyZSBy
aWdodCBmb3IgbmFtZSBvbg0KPj4gdGhlIHBhY2thZ2UuLi4NCj4+IFNvLCBhcmUgeW91IHVzaW5n
IHRoZSBMU00zMDNETEhDPw0KPiBBY2NvcmRpbmcgdG8gbXkgZGF0YXNoZWV0IFsxXSwgSSBoYXZl
IHRoZSBMU00zMDNETEguDQo+DQo+IFsxXSBodHRwOi8vd3d3LmNhbGFvLXN5c3RlbXMuY29tL3Jl
cG9zaXRvcnkvcHViL0VNQkVEREVEJTIwQ09NUFVURVJTL1NLWS1TOTUwMC1VTFAtWFhYL0MxMi1T
REsvU0NILTAwMTAzLUIxMS5wZGYNCj4NCk1oaC4uLkkgc2F3IHRoZSBMU00zMDNETEhDLi4uDQpU
aGUgTFNNMzAzRExIIGlzIG5vdCBwb3B1bGF0ZWQsIHRoZXJlIGlzIG9ubHkgdGhlIGZvb3Rwcmlu
dCBidXQgaXMgbm90IA0Kc29sZGVyZWQuLi4NCg0KRGVuaXM=
