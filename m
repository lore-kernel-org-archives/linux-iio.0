Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f176.google.com ([209.85.215.176]:41130 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeHaVsq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Aug 2018 17:48:46 -0400
Received: by mail-pg1-f176.google.com with SMTP id s15-v6so5752264pgv.8
        for <linux-iio@vger.kernel.org>; Fri, 31 Aug 2018 10:40:14 -0700 (PDT)
Subject: Re: Idea: regmap_config.use_single_rw -> use_single_read,
 use_single_write
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
References: <2992280e-55f0-00d6-24cd-30714891ddc9@gmail.com>
 <475b58c1-195c-d896-754e-2c84ff5b5e3e@gmail.com>
 <20180831170907.GA10015@himanshu-Vostro-3559>
 <20180831172027.GA10477@himanshu-Vostro-3559>
From: David Frey <dpfrey@gmail.com>
Message-ID: <126ec402-58dc-832b-cd34-e444c5bd8856@gmail.com>
Date: Fri, 31 Aug 2018 10:40:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180831172027.GA10477@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 8/31/2018 10:20 AM, Himanshu Jha wrote:
> On Fri, Aug 31, 2018 at 10:39:07PM +0530, Himanshu Jha wrote:
>> On Fri, Aug 31, 2018 at 07:55:36AM -0700, David Frey wrote:
>>> On 8/29/2018 10:35 AM, David Frey wrote:
>>>> Hi,
>>>>
>>>> I just want to float an idea and see if it gets any support.
>>>>
>>>> In struct regmap_config, there is a member "bool use_single_rw" which is
>>>> documented as follows:
>>>>
>>>> "If set, converts the bulk read and write operations into a series of
>>>> single read and write operations. This is useful for device that does
>>>> not support bulk read and write."
>>>>
>>>> My idea is to split this into:
>>>> 	bool use_single_read;
>>>> 	bool use_single_write;
>>>>
>>>> I think this would be useful because at least one device that I'm using
>>>> (Bosch bmi160 IMU) supports bulk reads, but not bulk writes.  It would
>>>> be convenient to be able to use regmap_bulk_read and regmap_bulk_write
>>>> and have only regmap_bulk_write split the writes apart.  This change
>>>> would also support the case where a device supports bulk writes, but not
>>>> bulk reads.  I don't know of such a device, but I haven't made any
>>>> attempt to find one.
>>>>
>>>> What do you think?
> 
> Btw, if device doesn't support a bulk write and instead only supports a bulk
> read as we see in BMI160, wouldn't the following suffice the problem:
> 
> 	.use_single_rw = true,
> 	.can_multi_write = false,  // or probably not setting it up(clear)
> 
>  313  * @can_multi_write: If set, the device supports the multi write mode of bulk
>  314  *                   write operations, if clear multi write requests will be
>  315  *                   split into individual write operations

I don't think the can_multi_write flag is relevant here.  Bulk writes
have the form: {regN, dataN, dataN+1, dataN+2, ...}.  Multi-write is
used by regmap_multi_reg_write() and is this form: {regaA, dataA, regF,
dataF, regC, dataC, ...}.
