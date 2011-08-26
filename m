Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:17589 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1HZV6m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 17:58:42 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id p7QLwf0b017583
	for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2011 14:58:41 -0700
Received: from gxk27 (gxk27.prod.google.com [10.202.11.27])
	by wpaz33.hot.corp.google.com with ESMTP id p7QLw7Vs010285
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2011 14:58:40 -0700
Received: by gxk27 with SMTP id 27so5626092gxk.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2011 14:58:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110826011542.GK5975@shale.localdomain>
References: <20110826011542.GK5975@shale.localdomain>
Date: Fri, 26 Aug 2011 14:58:39 -0700
Message-ID: <CANEJEGtys_kBMMPstRahrYq956g22ZgowySxvOCqUpHww6x29w@mail.gmail.com>
Subject: Re: STAGING:iio:light: fix ISL29018 init to handle brownout
From: Grant Grundler <grundler@google.com>
To: Dan Carpenter <error27@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Content-Type: multipart/mixed; boundary=000e0cd59448e4502904ab6fa52d
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--000e0cd59448e4502904ab6fa52d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2011 at 6:15 PM, Dan Carpenter <error27@gmail.com> wrote:
...
> In isl29018_write_data() it uses reg (ISL29018_REG_TEST) as the
> offset into the ->reg_cache[] array:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0chip->reg_cache[reg] =3D regval;
>
> But ->reg_cache[] only has 3 elements, so we're past the end of the
> array.

Dan,
I've attached a preliminary patch to fix this that applies on top of
176f9f29cec9 "STAGING:iio:light:
fix ISL29018 init to handle brownout".  This patch applies cleanly to
the 2.6.38-based chromium.org tree.

In a nutshell, the attached patch implements what I was thinking of
last night: don't cache REG_TEST.

I did change one basic behavior that I think was also broken: cache
the value regardless of if the transaction completed successfully or
not. For registers where we are frobbing bits, the later write to the
same register  might succeed and things will work anyway despite the
transient failure. If I'm wrong, please comment and I'll repost with
original behavior.

I also noticed the original code had an "off-by-one" error in the
allocation of reg_cache[] (allocated 3 but indexed up to offset +3).

I'll submit a cleaned up version that should cleanly apply to gregkh's
staging-2.6 tree.

thanks again!
grant

--000e0cd59448e4502904ab6fa52d
Content-Type: application/octet-stream; name="2.6.38-isl29018_reg_cache-01"
Content-Disposition: attachment; filename="2.6.38-isl29018_reg_cache-01"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grtod5wh0

Rml4IG91dC1vZi1ib3VuZHMgcmVmZXJlbmNlIHRvIHJlZ19jYWNoZVtdCgpTaW1wbGUgZml4IGlz
IHRvIGp1c3Qgbm90IGNhY2hlIFJFR19URVNUIChvZmZzZXQgOCkuIEl0IGRvZXNuJ3QgaGVscCBh
bnl3YXkKc2luY2Ugd2Ugd3JpdGUgYWxsIDggYml0cyBleGFjdGx5IG9uY2UgKGF0IHJlc3VtZS9p
bml0IHRpbWUpLgoKQWxzbyBmaXggYW4gIm9mZi1ieS1vbmUiIGFsbG9jYXRpb24gb2YgcmVnX2Nh
Y2hlW10gYXJyYXkgc2l6ZSB0aGF0CndhcyBpbiB0aGUgb3JpZ2luYWwgY29kZSBiZWZvcmUgSSB0
b3VjaGVkIGl0LgoKUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBHcmFudCBHcnVuZGxlciA8Z3J1bmRsZXJAY2hyb21pdW0ub3JnPgoK
LS0tLQpUaGFua3MgYWdhaW4gdG8gRGFuIENhcnBlbnRlciBmb3Igc3BvdHRpbmcgdGhlIG91dC1v
Zi1ib3VuZHMgYXJyYXkgcmVmZXJlbmNlLgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9p
aW8vbGlnaHQvaXNsMjkwMTguYyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vbGlnaHQvaXNsMjkwMTgu
YwppbmRleCAwZjk3NzM0Li5hNTI1OWZmIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlv
L2xpZ2h0L2lzbDI5MDE4LmMKKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9saWdodC9pc2wyOTAx
OC5jCkBAIC01MSw3ICs1MSw3IEBACiAKICNkZWZpbmUgSVNMMjkwMThfUkVHX0FERF9EQVRBX0xT
QgkweDAyCiAjZGVmaW5lIElTTDI5MDE4X1JFR19BRERfREFUQV9NU0IJMHgwMwotI2RlZmluZSBJ
U0wyOTAxOF9NQVhfUkVHUwkJSVNMMjkwMThfUkVHX0FERF9EQVRBX01TQgorI2RlZmluZSBJU0wy
OTAxOF9NQVhfUkVHUwkJSVNMMjkwMThfUkVHX0FERF9EQVRBX01TQisxCiAKICNkZWZpbmUgSVNM
MjkwMThfUkVHX1RFU1QJCTB4MDgKICNkZWZpbmUgSVNMMjkwMThfVEVTVF9TSElGVAkJMApAQCAt
NzEsMjIgKzcxLDIzIEBAIHN0cnVjdCBpc2wyOTAxOF9jaGlwIHsKIHN0YXRpYyBpbnQgaXNsMjkw
MThfd3JpdGVfZGF0YShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCB1OCByZWcsCiAJCQl1OCB2
YWwsIHU4IG1hc2ssIHU4IHNoaWZ0KQogewotCXU4IHJlZ3ZhbDsKLQlpbnQgcmV0ID0gMDsKKwl1
OCByZWd2YWwgPSB2YWw7CisJaW50IHJldDsKIAlzdHJ1Y3QgaXNsMjkwMThfY2hpcCAqY2hpcCA9
IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOwogCi0JcmVndmFsID0gY2hpcC0+cmVnX2NhY2hl
W3JlZ107Ci0JcmVndmFsICY9IH5tYXNrOwotCXJlZ3ZhbCB8PSB2YWwgPDwgc2hpZnQ7CisJLyog
ZG9uJ3QgY2FjaGUgUkVHX1RFU1QgKi8KKwlpZiAocmVnIDwgSVNMMjkwMThfTUFYX1JFR1MpIHsK
KwkJcmVndmFsID0gY2hpcC0+cmVnX2NhY2hlW3JlZ107CisJCXJlZ3ZhbCAmPSB+bWFzazsKKwkJ
cmVndmFsIHw9IHZhbCA8PCBzaGlmdDsKKwkJY2hpcC0+cmVnX2NhY2hlW3JlZ10gPSByZWd2YWw7
CisJfQogCiAJcmV0ID0gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShjbGllbnQsIHJlZywgcmVn
dmFsKTsKLQlpZiAocmV0KSB7CisJaWYgKHJldCkKIAkJZGV2X2VycigmY2xpZW50LT5kZXYsICJX
cml0ZSB0byBkZXZpY2UgZmFpbHMgc3RhdHVzICV4XG4iLCByZXQpOwotCQlyZXR1cm4gcmV0Owot
CX0KLQljaGlwLT5yZWdfY2FjaGVbcmVnXSA9IHJlZ3ZhbDsKIAotCXJldHVybiAwOworCXJldHVy
biByZXQ7CiB9CiAKIHN0YXRpYyBpbnQgaXNsMjkwMThfc2V0X3JhbmdlKHN0cnVjdCBpMmNfY2xp
ZW50ICpjbGllbnQsIHVuc2lnbmVkIGxvbmcgcmFuZ2UsCg==
--000e0cd59448e4502904ab6fa52d--
