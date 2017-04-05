Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:48373 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754551AbdDEAol (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Apr 2017 20:44:41 -0400
Message-ID: <1491353080.3695.4.camel@linux.intel.com>
Subject: Re: [STABLE REGRESSION] iio: hid-sensor-trigger: Change get poll
 value function order to avoid sensor properties losing after resume from S3
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rrs@researchut.com, Song Hongyan <hongyan.song@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Cc: stable@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 04 Apr 2017 17:44:40 -0700
In-Reply-To: <1491246858.17255.10.camel@researchut.com>
References: <1491035833.10386.1.camel@researchut.com>
         <1491059661.30396.37.camel@linux.intel.com>
         <1491246858.17255.10.camel@researchut.com>
Content-Type: multipart/mixed; boundary="=-RmHjhqxguuNnIzHAzons"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-RmHjhqxguuNnIzHAzons
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Ritesh,

Does the attached patch helps?

Thanks,
Srinivas

On Tue, 2017-04-04 at 00:44 +0530, Ritesh Raj Sarraf wrote:
> Adding Stable, LKML and IIO MLs.
> 
> Hello Hongyan,
> 
> Do you have any feedback ? With the bisected commit reverted, I've
> been
> successfully running the machine without any issues.
> 
> Ritesh
> 
> 
> On Sat, 2017-04-01 at 08:14 -0700, Srinivas Pandruvada wrote:
> > Hello Hongyan,
> > 
> > Can you check the findings of Ritesh?
> > 
> > Thanks,
> > Srinivas
> > 
> > On Sat, 2017-04-01 at 14:07 +0530, Ritesh Raj Sarraf wrote:
> > > Hello Srinivas,
> > > 
> > > With the Linux 4.10.7 release, I have encountered a regression
> > > introduced on my
> > > Lenovo Yoga 2 13, for the ITE Rotation Sensor.
> > > 
> > > 
> > > rrs@learner:~$ lsusb 
> > > Bus 001 Device 002: ID 8087:8000 Intel Corp. 
> > > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > Bus 003 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > > Bus 002 Device 006: ID 048d:8350 Integrated Technology Express,
> > > Inc. 
> > > Bus 002 Device 005: ID 0bda:b728 Realtek Semiconductor Corp. 
> > > Bus 002 Device 004: ID 04f2:b40f Chicony Electronics Co., Ltd 
> > > Bus 002 Device 003: ID 04f3:0303 Elan Microelectronics Corp. 
> > > Bus 002 Device 002: ID 0bda:0129 Realtek Semiconductor Corp.
> > > RTS5129
> > > Card Reader
> > > Controller
> > > Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > 2017-04-01 / 14:04:49 ♒♒♒  ☺  
> > > 
> > > 
> > > The ITE sensors do not feed any data on the 4.10.7 kernel.
> > > Reverting
> > > back to
> > > 4.10.5, everything works back.
> > > 
> > > 
> > > After a git bisect, the culprit reported is:
> > > 
> > > Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > > [6c2aab07d12436af1cd8d9ac1d117a442cc91eec] iio: hid-sensor-
> > > trigger:
> > > Change get
> > > poll value function order to avoid sensor properties losing after
> > > resume from S3
> > > 1
> > > 
> > > Can you please review my findings to confirm that it really is a
> > > regression bug
> > > ?
> > > 
> > > 
> > > Thanks,
> > > Ritesh
> > > 
--=-RmHjhqxguuNnIzHAzons
Content-Disposition: attachment;
	filename="0001-iio-hid-sensor-Store-restore-poll-and-hysteresis.patch"
Content-Type: text/x-patch;
	name="0001-iio-hid-sensor-Store-restore-poll-and-hysteresis.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA4MWE1NWJkOWU2ZGZiNGFlYzE1ZGEzN2EzYTNmZjgyMTNkNzg4ZjYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogVHVlLCA0IEFwciAyMDE3IDE2OjUwOjU5IC0wNzAw
ClN1YmplY3Q6IFtQQVRDSF0gaWlvOiBoaWQtc2Vuc29yOiBTdG9yZSByZXN0b3JlIHBvbGwgYW5k
IGh5c3RlcmVzaXMKCkluc3RlYWQgb2YgcmVseWluZyBvbiBIVyBmb3IgcmVzdG9yaW5nIHBvbGwg
YW5kIGh5c3RlcmVzaXMsIHN0b3JlIGluIGRyaXZlcgphbmQgcmVzdG9yZSBvbiByZXN1bWUuCgpT
aWduZWQtb2ZmLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxp
bnV4LmludGVsLmNvbT4KLS0tCiAuLi4vaWlvL2NvbW1vbi9oaWQtc2Vuc29ycy9oaWQtc2Vuc29y
LWF0dHJpYnV0ZXMuYyAgIHwgMTcgKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvaWlvL2NvbW1v
bi9oaWQtc2Vuc29ycy9oaWQtc2Vuc29yLXRyaWdnZXIuYyAgfCAyMCArKysrKysrKysrKysrKysr
Ky0tLQogaW5jbHVkZS9saW51eC9oaWQtc2Vuc29yLWh1Yi5oICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyICsrCiAzIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vY29tbW9uL2hpZC1zZW5zb3JzL2hpZC1zZW5z
b3ItYXR0cmlidXRlcy5jIGIvZHJpdmVycy9paW8vY29tbW9uL2hpZC1zZW5zb3JzL2hpZC1zZW5z
b3ItYXR0cmlidXRlcy5jCmluZGV4IDdhZmRhYzQyLi5hYThjYWNmIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2lpby9jb21tb24vaGlkLXNlbnNvcnMvaGlkLXNlbnNvci1hdHRyaWJ1dGVzLmMKKysrIGIv
ZHJpdmVycy9paW8vY29tbW9uL2hpZC1zZW5zb3JzL2hpZC1zZW5zb3ItYXR0cmlidXRlcy5jCkBA
IC0yMjEsNiArMjIxLDE0IEBAIGludCBoaWRfc2Vuc29yX3dyaXRlX3NhbXBfZnJlcV92YWx1ZShz
dHJ1Y3QgaGlkX3NlbnNvcl9jb21tb24gKnN0LAogCWlmIChyZXQgPCAwIHx8IHZhbHVlIDwgMCkK
IAkJcmV0ID0gLUVJTlZBTDsKIAorCXJldCA9IHNlbnNvcl9odWJfZ2V0X2ZlYXR1cmUoc3QtPmhz
ZGV2LAorCQkJCSAgICAgc3QtPnBvbGwucmVwb3J0X2lkLAorCQkJCSAgICAgc3QtPnBvbGwuaW5k
ZXgsIHNpemVvZih2YWx1ZSksICZ2YWx1ZSk7CisJaWYgKHJldCA8IDAgfHwgdmFsdWUgPCAwKQor
CQlyZXR1cm4gLUVJTlZBTDsKKworCXN0LT5wb2xsX2ludGVydmFsID0gdmFsdWU7CisKIAlyZXR1
cm4gcmV0OwogfQogRVhQT1JUX1NZTUJPTChoaWRfc2Vuc29yX3dyaXRlX3NhbXBfZnJlcV92YWx1
ZSk7CkBAIC0yNjYsNiArMjc0LDE1IEBAIGludCBoaWRfc2Vuc29yX3dyaXRlX3Jhd19oeXN0X3Zh
bHVlKHN0cnVjdCBoaWRfc2Vuc29yX2NvbW1vbiAqc3QsCiAJaWYgKHJldCA8IDAgfHwgdmFsdWUg
PCAwKQogCQlyZXQgPSAtRUlOVkFMOwogCisJcmV0ID0gc2Vuc29yX2h1Yl9nZXRfZmVhdHVyZShz
dC0+aHNkZXYsCisJCQkJICAgICBzdC0+c2Vuc2l0aXZpdHkucmVwb3J0X2lkLAorCQkJCSAgICAg
c3QtPnNlbnNpdGl2aXR5LmluZGV4LCBzaXplb2YodmFsdWUpLAorCQkJCSAgICAgJnZhbHVlKTsK
KwlpZiAocmV0IDwgMCB8fCB2YWx1ZSA8IDApCisJCXJldHVybiAtRUlOVkFMOworCisJc3QtPnJh
d19oeXN0ZXJzaXMgPSB2YWx1ZTsKKwogCXJldHVybiByZXQ7CiB9CiBFWFBPUlRfU1lNQk9MKGhp
ZF9zZW5zb3Jfd3JpdGVfcmF3X2h5c3RfdmFsdWUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
Y29tbW9uL2hpZC1zZW5zb3JzL2hpZC1zZW5zb3ItdHJpZ2dlci5jIGIvZHJpdmVycy9paW8vY29t
bW9uL2hpZC1zZW5zb3JzL2hpZC1zZW5zb3ItdHJpZ2dlci5jCmluZGV4IGVjZjU5MmQuLmJlNzAx
MWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaWlvL2NvbW1vbi9oaWQtc2Vuc29ycy9oaWQtc2Vuc29y
LXRyaWdnZXIuYworKysgYi9kcml2ZXJzL2lpby9jb21tb24vaGlkLXNlbnNvcnMvaGlkLXNlbnNv
ci10cmlnZ2VyLmMKQEAgLTUxLDYgKzUxLDggQEAgc3RhdGljIGludCBfaGlkX3NlbnNvcl9wb3dl
cl9zdGF0ZShzdHJ1Y3QgaGlkX3NlbnNvcl9jb21tb24gKnN0LCBib29sIHN0YXRlKQogCQkJc3Qt
PnJlcG9ydF9zdGF0ZS5yZXBvcnRfaWQsCiAJCQlzdC0+cmVwb3J0X3N0YXRlLmluZGV4LAogCQkJ
SElEX1VTQUdFX1NFTlNPUl9QUk9QX1JFUE9SVElOR19TVEFURV9BTExfRVZFTlRTX0VOVU0pOwor
CisJCXBvbGxfdmFsdWUgPSBoaWRfc2Vuc29yX3JlYWRfcG9sbF92YWx1ZShzdCk7CiAJfSBlbHNl
IHsKIAkJaW50IHZhbDsKIApAQCAtODcsOSArODksNyBAQCBzdGF0aWMgaW50IF9oaWRfc2Vuc29y
X3Bvd2VyX3N0YXRlKHN0cnVjdCBoaWRfc2Vuc29yX2NvbW1vbiAqc3QsIGJvb2wgc3RhdGUpCiAJ
c2Vuc29yX2h1Yl9nZXRfZmVhdHVyZShzdC0+aHNkZXYsIHN0LT5wb3dlcl9zdGF0ZS5yZXBvcnRf
aWQsCiAJCQkgICAgICAgc3QtPnBvd2VyX3N0YXRlLmluZGV4LAogCQkJICAgICAgIHNpemVvZihz
dGF0ZV92YWwpLCAmc3RhdGVfdmFsKTsKLQlpZiAoc3RhdGUpCi0JCXBvbGxfdmFsdWUgPSBoaWRf
c2Vuc29yX3JlYWRfcG9sbF92YWx1ZShzdCk7Ci0JaWYgKHBvbGxfdmFsdWUgPiAwKQorCWlmIChz
dGF0ZSAmJiBwb2xsX3ZhbHVlKQogCQltc2xlZXBfaW50ZXJydXB0aWJsZShwb2xsX3ZhbHVlICog
Mik7CiAKIAlyZXR1cm4gMDsKQEAgLTEyNyw2ICsxMjcsMjAgQEAgc3RhdGljIHZvaWQgaGlkX3Nl
bnNvcl9zZXRfcG93ZXJfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJc3RydWN0IGhp
ZF9zZW5zb3JfY29tbW9uICphdHRyYiA9IGNvbnRhaW5lcl9vZih3b3JrLAogCQkJCQkJICAgICAg
IHN0cnVjdCBoaWRfc2Vuc29yX2NvbW1vbiwKIAkJCQkJCSAgICAgICB3b3JrKTsKKworCWlmIChh
dHRyYi0+cG9sbF9pbnRlcnZhbCkKKwkJc2Vuc29yX2h1Yl9zZXRfZmVhdHVyZShhdHRyYi0+aHNk
ZXYsIGF0dHJiLT5wb2xsLnJlcG9ydF9pZCwKKwkJCQkgICAgICAgYXR0cmItPnBvbGwuaW5kZXgs
CisJCQkJICAgICAgIHNpemVvZihhdHRyYi0+cG9sbF9pbnRlcnZhbCksCisJCQkJICAgICAgICZh
dHRyYi0+cG9sbF9pbnRlcnZhbCk7CisKKwlpZiAoYXR0cmItPnJhd19oeXN0ZXJzaXMpCisJCXNl
bnNvcl9odWJfc2V0X2ZlYXR1cmUoYXR0cmItPmhzZGV2LAorCQkJCSAgICAgICBhdHRyYi0+c2Vu
c2l0aXZpdHkucmVwb3J0X2lkLAorCQkJCSAgICAgICBhdHRyYi0+c2Vuc2l0aXZpdHkuaW5kZXgs
CisJCQkJICAgICAgIHNpemVvZihhdHRyYi0+cmF3X2h5c3RlcnNpcyksCisJCQkJICAgICAgICZh
dHRyYi0+cmF3X2h5c3RlcnNpcyk7CisKIAlfaGlkX3NlbnNvcl9wb3dlcl9zdGF0ZShhdHRyYiwg
dHJ1ZSk7CiB9CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaGlkLXNlbnNvci1odWIuaCBi
L2luY2x1ZGUvbGludXgvaGlkLXNlbnNvci1odWIuaAppbmRleCA3ZWYxMTFkLi5mMzJkN2MzIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2hpZC1zZW5zb3ItaHViLmgKKysrIGIvaW5jbHVkZS9s
aW51eC9oaWQtc2Vuc29yLWh1Yi5oCkBAIC0yMzEsNiArMjMxLDggQEAgc3RydWN0IGhpZF9zZW5z
b3JfY29tbW9uIHsKIAl1bnNpZ25lZCB1c2FnZV9pZDsKIAlhdG9taWNfdCBkYXRhX3JlYWR5Owog
CWF0b21pY190IHVzZXJfcmVxdWVzdGVkX3N0YXRlOworCWludCBwb2xsX2ludGVydmFsOworCWlu
dCByYXdfaHlzdGVyc2lzOwogCXN0cnVjdCBpaW9fdHJpZ2dlciAqdHJpZ2dlcjsKIAlpbnQgdGlt
ZXN0YW1wX25zX3NjYWxlOwogCXN0cnVjdCBoaWRfc2Vuc29yX2h1Yl9hdHRyaWJ1dGVfaW5mbyBw
b2xsOwotLSAKMi45LjMKCg==


--=-RmHjhqxguuNnIzHAzons--

