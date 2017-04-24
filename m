Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:42874 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168463AbdDXLl3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2017 07:41:29 -0400
Subject: Re: [PATCH v2] tools/iio: Use include/uapi with __EXPORTED_HEADERS__
To: Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <5cfc29b0d8fa6c5bd97e59f7ab0ff718132efdec.1492777014.git.nsekhar@ti.com>
 <0a357589-7169-5cff-e842-657b52049b15@infradead.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <f257820e-7010-72d8-c005-924a158ee4c1@ti.com>
Date: Mon, 24 Apr 2017 17:10:38 +0530
MIME-Version: 1.0
In-Reply-To: <0a357589-7169-5cff-e842-657b52049b15@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Randy,

On Sunday 23 April 2017 07:52 AM, Randy Dunlap wrote:
> On 04/21/17 05:31, Sekhar Nori wrote:
>> Use the local uapi headers to keep in sync with "recently" added enum
>> values like IIO_UVINDEX.
>>
>> Build tested using:
>> $ make -C <kernelsrcdir> tools/iio
>> $ make -C <kernelsrcdir>/tools iio
>> $ make -C <kernelsrcdir>/tools/iio
> 
> Hi,
> Did you do any testing with O=<outputdir> ?

I hadn't, but I just checked with:

$ make -C <kernelsrcdir>/tools iio O=<outputdir>

Although there is an iio folder created under <outputdir>, the actual
binaries are still built under <kernelsrcdir>/tools/iio. So I think
there is some more work to be done to respect the O= option passed from
command line.

The behavior remains same with or without my patch.

Thanks,
Sekhar
