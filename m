Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:40955 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756293AbcIPRnD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Sep 2016 13:43:03 -0400
Message-ID: <1474047781.32019.1.camel@linux.intel.com>
Subject: Re: possible odd acceleration scaling
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rrs@researchut.com, Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date: Fri, 16 Sep 2016 10:43:01 -0700
In-Reply-To: <1473868832.9913.14.camel@researchut.com>
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
Content-Type: multipart/mixed; boundary="=-iaT1YROB2frLO5U2hExQ"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-iaT1YROB2frLO5U2hExQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Ritesh,


On Wed, 2016-09-14 at 21:30 +0530, Ritesh Raj Sarraf wrote:
> Hello Bastien,
> 
> On Wed, 2016-09-14 at 17:44 +0200, Bastien Nocera wrote:
> > 
> > 
> > My guess:
> > -       return (int) (info_1->index - info_2->index);
> > +       return ((int) info_1->index - (int) info_2->index);
> > 
Can you try attached patch for both 4.7 and 4.8 kernel?

Thanks,
Srinivas

> > Ritesh, could you try to change those lines in
> > compare_channel_index()
> > in src/iio-buffer-utils.c and capture another log if it fails?
> 
> That did not seem to change anything. I've put up the log at:
> https://people.debian.org/~rrs/tmp/iio-int.txt
> 
>  
--=-iaT1YROB2frLO5U2hExQ
Content-Disposition: attachment; filename="0001-Fix-sorting.patch"
Content-Type: text/x-patch; name="0001-Fix-sorting.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA1NTNmYjVhY2UxYjEzMWM3YzBmMTQ2YTc3MjE2ODg3OWQ2ZjhjNzA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogRnJpLCAxNiBTZXAgMjAxNiAxMDozMTowMCAtMDcw
MApTdWJqZWN0OiBbUEFUQ0hdIEZpeCBzb3J0aW5nCgpOZWVkIHRvIGRlcmVmZXJuY2UgcGFyYW1l
dGVycyBwYXNzZWQgdG8gY29tcGFyZSBjYWxsYmFjay4KLS0tCiBzcmMvaWlvLWJ1ZmZlci11dGls
cy5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NyYy9paW8tYnVmZmVyLXV0aWxzLmMgYi9zcmMvaWlvLWJ1ZmZl
ci11dGlscy5jCmluZGV4IDQ0MGE4YjcuLjBiMjRiYWMgMTAwNjQ0Ci0tLSBhL3NyYy9paW8tYnVm
ZmVyLXV0aWxzLmMKKysrIGIvc3JjL2lpby1idWZmZXItdXRpbHMuYwpAQCAtMjAwLDggKzIwMCw4
IEBAIGNoYW5uZWxfaW5mb19mcmVlIChpaW9fY2hhbm5lbF9pbmZvICpjaSkKIHN0YXRpYyBpbnQK
IGNvbXBhcmVfY2hhbm5lbF9pbmRleCAoZ2NvbnN0cG9pbnRlciBhLCBnY29uc3Rwb2ludGVyIGIp
CiB7Ci0JY29uc3QgaWlvX2NoYW5uZWxfaW5mbyAqaW5mb18xID0gYTsKLQljb25zdCBpaW9fY2hh
bm5lbF9pbmZvICppbmZvXzIgPSBiOworCWNvbnN0IGlpb19jaGFubmVsX2luZm8gKmluZm9fMSA9
ICooaWlvX2NoYW5uZWxfaW5mbyAqKikgYTsKKwljb25zdCBpaW9fY2hhbm5lbF9pbmZvICppbmZv
XzIgPSAqKGlpb19jaGFubmVsX2luZm8gKiopIGI7CiAKIAlyZXR1cm4gKGludCkgKGluZm9fMS0+
aW5kZXggLSBpbmZvXzItPmluZGV4KTsKIH0KLS0gCjIuNy40Cgo=


--=-iaT1YROB2frLO5U2hExQ--

