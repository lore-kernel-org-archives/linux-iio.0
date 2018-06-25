Return-Path: <SRS0=iv4G=JL=analog.com=alexandru.Ardelean@kernel.org>
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "Hennerich, Michael"
	<Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: ad9523: replace core mlock with local lock
Date: Mon, 25 Jun 2018 07:57:49 +0000
Message-ID: <6ef9836e68da91552d46f74e9730d0ac54d3cc99.camel@analog.com>
References: <20180625072808.8796-1-alexandru.ardelean@analog.com>
	 <d177617b-7d83-8243-27e5-de77a571275b@metafoo.de>
In-Reply-To: <d177617b-7d83-8243-27e5-de77a571275b@metafoo.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

T24gTW9uLCAyMDE4LTA2LTI1IGF0IDA5OjM1ICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IE9uIDA2LzI1LzIwMTggMDk6MjggQU0sIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToN
Cj4gPiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiANCj4g
PiBUaGlzIGlzIHBhcnQgb2YgYSBsb25nIHRlcm0gZWZmb3J0IHRvIG1ha2UgdGhlIHVzZSBvZiBt
bG9jayBvcGFxdWUgYW5kDQo+ID4gc2luZ2xlIHB1cnBvc2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+IA0KPiBXaGVuIHlv
dSBzZW5kIGEgcGF0Y2ggeW91IG5lZWQgdG8gc2lnbiBvZmYgb24gaXQuDQo+IA0KQWNrLg0KDQpX
aWxsIHJlLXNlbmQ=
