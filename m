Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50326 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966399AbaLLOTf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 12 Dec 2014 09:19:35 -0500
From: "Griffis, Brad" <bgriffis@ti.com>
To: Catalin Crenguta <catalin.crenguta@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Nicolae Rosia <nicolae.rosia@gmail.com>,
	"R, Vignesh" <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Benoit Cousson <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@arm.linux.org.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Samuel Ortiz <sameo@linux.intel.com>,
	"Balbi, Felipe" <balbi@ti.com>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Jan Kardell <jan.kardell@telliq.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH v4 0/6] Touchscreen performance related fixes
Date: Fri, 12 Dec 2014 14:16:29 +0000
Message-ID: <912A29987EAE174BA6CF187D7CDFA9CE26FA135A@DLEE08.ent.ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
	<20141124115116.GA14997@linutronix.de>	<547C3A95.30605@ti.com>
	<547C3C19.5090501@linutronix.de>	<547C42FF.5010700@ti.com>
	<CAH=tA9FO5MCzE274thc-NugCNte6WdyC-Rxc6yfnuR=+6_qMbA@mail.gmail.com>
	<548A0125.6040708@linutronix.de>
 <CABH3fy8zCjsxARsqBf9JXOHBkzySdiqifA1KtjnGpJdBY2EikA@mail.gmail.com>
In-Reply-To: <CABH3fy8zCjsxARsqBf9JXOHBkzySdiqifA1KtjnGpJdBY2EikA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDYXRhbGluIENyZW5ndXRhIFtt
YWlsdG86Y2F0YWxpbi5jcmVuZ3V0YUBnbWFpbC5jb21dDQo+IEkgaGF2ZSB0cmllZCB5b3VyIHBh
dGNoZXMgYnkgY2xvbmluZyBbMV0gYW5kIGNvcHlpbmcgdGhlIHJlbGV2YW50IGZpbGVzIG92ZXIN
Cj4gdGhlIGtlcm5lbCBJJ3ZlIGNsb25lZCBmcm9tIFsyXS4NCj4gSXQgY29tcGlsZXMgJiBydW5z
LCBidXQgSSdtIHNlZWluZyBsb3RzIG9mIHBlbi1kb3duL3Blbi11cCBldmVudHMgd2hlbiBJJ20N
Cj4gbm90IHRvdWNoaW5nIHRoZSBzY3JlZW4uDQo+IEFueSBzdWdnZXN0aW9ucz8NCg0KSG93IGFy
ZSB5b3UgY29uZmlndXJpbmcgdGksY2hhcmdlLWRlbGF5IGluIHlvdXIgZHRzPyAgSSd2ZSBzZWVu
IHRoaXMgYmVoYXZpb3Igb24gc29tZSBjdXN0b20gYm9hcmRzIHdoZXJlIHdlIHdlcmUgdXNpbmcg
YSBzbWFsbGVyIGNoYXJnZSBkZWxheSAoMHg0MDApIHRvIGJlZ2luIHdpdGgsIGFuZCBieSB1cHBp
bmcgaXQgdG8gMHhiMDAwIHdlIHJlc29sdmVkIHRoZSBpc3N1ZS4gIFRoZXNlIHBhdGNoZXMgaG93
ZXZlciBhbHJlYWR5IHNwZWNpZmllZCB0aSxjaGFyZ2UtZGVsYXkgPSAweGIwMDAgYnkgZGVmYXVs
dCBzbyB0aGlzIHdvdWxkIHN1cnByaXNlIG1lIHRoYXQgaXQncyBzdGlsbCBzZWVpbmcgdGhhdCBp
c3N1ZS4gIFdhcyB0aGUgdG91Y2hzY3JlZW4gd29ya2luZyBhcyBleHBlY3RlZCBiZWZvcmUgdGhl
c2UgbmV3IHBhdGNoZXMsIG9yIGRvZXMgaXQgaGF2ZSBpc3N1ZXMgYm90aCB3YXlzPw0K
