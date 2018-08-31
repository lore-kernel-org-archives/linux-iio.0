Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f173.google.com ([209.85.210.173]:43160 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeHaTDb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Aug 2018 15:03:31 -0400
Received: by mail-pf1-f173.google.com with SMTP id j26-v6so5629035pfi.10
        for <linux-iio@vger.kernel.org>; Fri, 31 Aug 2018 07:55:39 -0700 (PDT)
Received: from [192.168.1.72] (d23-16-64-84.bchsia.telus.net. [23.16.64.84])
        by smtp.gmail.com with ESMTPSA id a19-v6sm24944259pfj.38.2018.08.31.07.55.37
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 07:55:38 -0700 (PDT)
Subject: Re: Idea: regmap_config.use_single_rw -> use_single_read,
 use_single_write
From: David Frey <dpfrey@gmail.com>
To: linux-iio <linux-iio@vger.kernel.org>
References: <2992280e-55f0-00d6-24cd-30714891ddc9@gmail.com>
Message-ID: <475b58c1-195c-d896-754e-2c84ff5b5e3e@gmail.com>
Date: Fri, 31 Aug 2018 07:55:36 -0700
MIME-Version: 1.0
In-Reply-To: <2992280e-55f0-00d6-24cd-30714891ddc9@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 8/29/2018 10:35 AM, David Frey wrote:
> Hi,
> 
> I just want to float an idea and see if it gets any support.
> 
> In struct regmap_config, there is a member "bool use_single_rw" which is
> documented as follows:
> 
> "If set, converts the bulk read and write operations into a series of
> single read and write operations. This is useful for device that does
> not support bulk read and write."
> 
> My idea is to split this into:
> 	bool use_single_read;
> 	bool use_single_write;
> 
> I think this would be useful because at least one device that I'm using
> (Bosch bmi160 IMU) supports bulk reads, but not bulk writes.  It would
> be convenient to be able to use regmap_bulk_read and regmap_bulk_write
> and have only regmap_bulk_write split the writes apart.  This change
> would also support the case where a device supports bulk writes, but not
> bulk reads.  I don't know of such a device, but I haven't made any
> attempt to find one.
> 
> What do you think?
> 
> David Frey

I realized after I sent this that this is a regmap change and thus might
be out of scope for discussion on the linux-iio mailing list.  Is there
somewhere more appropriate to post this to?

Thanks,
David
