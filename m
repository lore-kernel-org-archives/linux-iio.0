Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:65196 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbaHVSpp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Aug 2014 14:45:45 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so93153wiv.15
        for <linux-iio@vger.kernel.org>; Fri, 22 Aug 2014 11:45:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN0s7yT017sCS9K4q5avRBz5JM+Oj4RM-M8oYVStbWEDx1yWXg@mail.gmail.com>
References: <CAN0s7yTK1_1u65nodysfiGxYbgKTeDS0Vf_+14KQJS92_Di1vg@mail.gmail.com>
 <CAN0s7yRwXGgPLhyucnR+=EybQFjunt66MKYvQuZnR_PSdgjS1Q@mail.gmail.com>
 <CA+BWVUSSO0kA1mW6BJ9F5VrZErK1D7YDOrA-gtuW5ZF3wNNZXA@mail.gmail.com>
 <CAN0s7yTYwEsu2uJ3kUjW-SsvoyqSXebNT3=1D1oNfdJwi=Q5Qw@mail.gmail.com>
 <CA+BWVUSZDb_+gtLY5JeryMMfYRrQCkdYBUfG9m3rzL1P9wawYg@mail.gmail.com>
 <CA+BWVUSvm54_xLeXGf0d5oo1-1DH_z=K1TFsrFLQHMBV_gA7gA@mail.gmail.com> <CAN0s7yT017sCS9K4q5avRBz5JM+Oj4RM-M8oYVStbWEDx1yWXg@mail.gmail.com>
From: Reyad Attiyat <reyad.attiyat@gmail.com>
Date: Fri, 22 Aug 2014 13:45:22 -0500
Message-ID: <CA+BWVUSXXhFFTUg_NUu6KochOnpg7LF9L3Q8pZHe4Lt7JJrEXw@mail.gmail.com>
Subject: Re: Resource Temporarily Unavailable error when trying to read from
 the accelerator on a ThinkPad twist
To: Elad Alfassa <elad@fedoraproject.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: multipart/mixed; boundary=bcaec53d5eb5a6570305013c3e8d
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--bcaec53d5eb5a6570305013c3e8d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Elad,

I read through the commit log for the hid-sensor-hub and noticed this commi=
t:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/driv=
ers/hid/hid-sensor-hub.c?id=3Daf5666e0f76023d9c296016024297903a4c83108
It adds support for the ms surface but removes support for an STM
sensor hub, which matches your STM sensor hub product id.

Sorry I didn't catch this before. This probably explains the
regression you experienced when upgrading from 3.15-3.16.

I have attached a patch that fixes this deletion and ensures your
devices sensor hub is set up correctly. If the patch works you should
get continuous printing of new data from the iio device and new or
changing values from the in_accel_x_raw when moving your laptop.

I noticed your values were negative when you read from the
in_accel_x_raw. When I read from my device i get values in the range
of 0-65433. You might need some offset set as well but first test this
patch to add your device to the quirks list.

Thank you,
Reyad Attiyat


On Fri, Aug 22, 2014 at 6:44 AM, Elad Alfassa <elad@fedoraproject.org> wrot=
e:
> Hello Reyad!
>
> I've preformed the steps to enable the scan elements and the buffer,
> and when using `cat` on the character device I got some gibberish
> (looked like =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD /=EF=BF=BD=EF=BF=BD=EF=
=BF=BD).
>
> Here's the dmeg output: https://elad.fedorapeople.org/iio-debug/dmesg.txt
> and here's the rdesc file: https://elad.fedorapeople.org/iio-debug/rdesc.=
txt
>
> Furthermore, after preforming these steps, I tried to read the _raw files=
,
> [root@rincewind iio:device3]# cat in_accel_*raw
> -27
> 56
> -974
>
> According to the developer of iio-sensor-proxy the numbers should
> always be lower than 400, and as you can see one of the raw values is
> 974
>
> It seems that iio-sensor-proxy is getting EAGAIN when trying to read
> the data, but I can still cat the raw files.
> Examining the iio-sensor-proxy output it seems that it manages to read
> the sensor data ONCE and then gets EAGAIN in all the following read
> attempts.
>
> ** (process:2889): DEBUG: Found accel_3d at
> /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.0/0003:0483:9=
1D1.0003/HID-SENSOR-200073.1.auto/iio:device3
> ** (process:2889): DEBUG: Found associated trigger at
> /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.0/0003:0483:9=
1D1.0003/HID-SENSOR-200073.1.auto/trigger3
> ** (process:2889): DEBUG: Got type for in_accel_x: is signed: 1,
> bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
> ** (process:2889): DEBUG: Got type for in_accel_y: is signed: 1,
> bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
> ** (process:2889): DEBUG: Got type for in_accel_z: is signed: 1,
> bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
> ** (process:2889): DEBUG: Built channel array for in_accel_x: is
> signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
> ** (process:2889): DEBUG: Built channel array for in_accel_y: is
> signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
> ** (process:2889): DEBUG: Built channel array for in_accel_z: is
> signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
> ** (process:2889): DEBUG: Read from IIO: 18, -51, -976
> ** (process:2889): DEBUG: Found orientation: undefined, prev:undefined
>
> ** (process:2889): WARNING **: Couldn't read from device: Resource
> temporarily unavailable
> ** (process:2889): DEBUG: Found orientation: undefined, prev:undefined
>
> ** (process:2889): WARNING **: Couldn't read from device: Resource
> temporarily unavailable
> ** (process:2889): DEBUG: Found orientation: undefined, prev:undefined
> ^C
>
>
> While trying to figure out what's going on, I tried to `cat` the _raw
> files while iio-sensor-proxy was running, and I noticed that every
> time I `cat` them, iio-sensor-proxy can read the data too!
>
> So, we have two issues here:
> 1) The numbers returned from the raw file are "weird", as
> iio-sensor-proxy expects them to be under 400
> 2) When iio-sensor-proxy is running it can't read the data until I
> manually read the _raw files in a different terminal window, upon
> which iio-sensor-proxy suddenly gets the data too.
>
> I hope this helps debug the issue.
>
> Do you think it's a driver problem, or is it iio-sensor-proxy doing
> something wrong?
>
> --
> -Elad Alfassa.

--bcaec53d5eb5a6570305013c3e8d
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-hid-hid-sensor-hub-Add-support-for-STM-sensor-hub.patch"
Content-Disposition: attachment;
	filename="0001-hid-hid-sensor-hub-Add-support-for-STM-sensor-hub.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hz5uvypm0

RnJvbSAwODEwN2RjMzMwODBjNDFmYzhjMGI4MzUxZGY4YzcwZTU2MzUzNWYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZXlhZCBBdHRpeWF0IDxyZXlhZC5hdHRpeWF0QGdtYWlsLmNv
bT4KRGF0ZTogRnJpLCAyMiBBdWcgMjAxNCAxMzoxNDo1NSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGhpZDogaGlkLXNlbnNvci1odWI6IEFkZCBzdXBwb3J0IGZvciBTVE0gc2Vuc29yIGh1YgoKUmVu
YW1lIElEIGZvciBTVE0gc2Vuc29yIGh1YiB0byBtYXRjaCBvdGhlcnMuCkFkZCBzZW5zb3IgaHVi
IGVudW0gcXVpcmssIGZvciBTVE0gZGV2aWNlICgweDkxZDEpLAp0byBlbmFibGUgcHJvcGVyIGJp
dHMgaW4gdGhlIFVTQiBISUQgcmVwb3J0LgoKU2lnbmVkLW9mZi1ieTogUmV5YWQgQXR0aXlhdCA8
cmV5YWQuYXR0aXlhdEBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9oaWQvaGlkLWlkcy5oICAgICAg
ICB8IDIgKy0KIGRyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMgfCAzICsrKwogMiBmaWxlcyBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2hpZC9oaWQtaWRzLmggYi9kcml2ZXJzL2hpZC9oaWQtaWRzLmgKaW5kZXggMjVjZDY3NC4u
MjAyNWU5NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvaGlkLWlkcy5oCisrKyBiL2RyaXZlcnMv
aGlkL2hpZC1pZHMuaApAQCAtNDYzLDcgKzQ2Myw3IEBACiAjZGVmaW5lIFVTQl9ERVZJQ0VfSURf
SU5URUxfSElEX1NFTlNPUl8xCTB4MGEwNAogCiAjZGVmaW5lIFVTQl9WRU5ET1JfSURfU1RNXzAg
ICAgICAgICAgICAgMHgwNDgzCi0jZGVmaW5lIFVTQl9ERVZJQ0VfSURfU1RNX0hJRF9TRU5TT1Ig
ICAgMHg5MWQxCisjZGVmaW5lIFVTQl9ERVZJQ0VfSURfU1RNX0hJRF9TRU5TT1JfMCAgMHg5MWQx
CiAjZGVmaW5lIFVTQl9ERVZJQ0VfSURfU1RNX0hJRF9TRU5TT1JfMSAgMHg5MTAwCiAKICNkZWZp
bmUgVVNCX1ZFTkRPUl9JRF9JT04JCTB4MTVlNApkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlk
LXNlbnNvci1odWIuYyBiL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMKaW5kZXggZTI0NGU0
NC4uNjVjMWJiOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvaGlkLXNlbnNvci1odWIuYworKysg
Yi9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jCkBAIC03MjAsNiArNzIwLDkgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBoaWRfZGV2aWNlX2lkIHNlbnNvcl9odWJfZGV2aWNlc1tdID0gewogCQkJ
VVNCX0RFVklDRV9JRF9NU19UWVBFX0NPVkVSXzIpLAogCQkJLmRyaXZlcl9kYXRhID0gSElEX1NF
TlNPUl9IVUJfRU5VTV9RVUlSS30sCiAJeyBISURfREVWSUNFKEhJRF9CVVNfQU5ZLCBISURfR1JP
VVBfU0VOU09SX0hVQiwgVVNCX1ZFTkRPUl9JRF9TVE1fMCwKKwkJCVVTQl9ERVZJQ0VfSURfU1RN
X0hJRF9TRU5TT1JfMCksCisJCQkuZHJpdmVyX2RhdGEgPSBISURfU0VOU09SX0hVQl9FTlVNX1FV
SVJLfSwKKwl7IEhJRF9ERVZJQ0UoSElEX0JVU19BTlksIEhJRF9HUk9VUF9TRU5TT1JfSFVCLCBV
U0JfVkVORE9SX0lEX1NUTV8wLAogCQkJVVNCX0RFVklDRV9JRF9TVE1fSElEX1NFTlNPUl8xKSwK
IAkJCS5kcml2ZXJfZGF0YSA9IEhJRF9TRU5TT1JfSFVCX0VOVU1fUVVJUkt9LAogCXsgSElEX0RF
VklDRShISURfQlVTX0FOWSwgSElEX0dST1VQX1NFTlNPUl9IVUIsIFVTQl9WRU5ET1JfSURfVEVY
QVNfSU5TVFJVTUVOVFMsCi0tIAoxLjkuMwoK
--bcaec53d5eb5a6570305013c3e8d--
