Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45203 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeHaVRk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Aug 2018 17:17:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4-v6so5711004pgv.12
        for <linux-iio@vger.kernel.org>; Fri, 31 Aug 2018 10:09:15 -0700 (PDT)
Date: Fri, 31 Aug 2018 22:39:07 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Idea: regmap_config.use_single_rw -> use_single_read,
 use_single_write
Message-ID: <20180831170907.GA10015@himanshu-Vostro-3559>
References: <2992280e-55f0-00d6-24cd-30714891ddc9@gmail.com>
 <475b58c1-195c-d896-754e-2c84ff5b5e3e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <475b58c1-195c-d896-754e-2c84ff5b5e3e@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 31, 2018 at 07:55:36AM -0700, David Frey wrote:
> On 8/29/2018 10:35 AM, David Frey wrote:
> > Hi,
> > 
> > I just want to float an idea and see if it gets any support.
> > 
> > In struct regmap_config, there is a member "bool use_single_rw" which is
> > documented as follows:
> > 
> > "If set, converts the bulk read and write operations into a series of
> > single read and write operations. This is useful for device that does
> > not support bulk read and write."
> > 
> > My idea is to split this into:
> > 	bool use_single_read;
> > 	bool use_single_write;
> > 
> > I think this would be useful because at least one device that I'm using
> > (Bosch bmi160 IMU) supports bulk reads, but not bulk writes.  It would
> > be convenient to be able to use regmap_bulk_read and regmap_bulk_write
> > and have only regmap_bulk_write split the writes apart.  This change
> > would also support the case where a device supports bulk writes, but not
> > bulk reads.  I don't know of such a device, but I haven't made any
> > attempt to find one.
> > 
> > What do you think?
> > 
> > David Frey
> 
> I realized after I sent this that this is a regmap change and thus might
> be out of scope for discussion on the linux-iio mailing list.  Is there
> somewhere more appropriate to post this to?

himanshu@himanshu-Vostro-3559:~/linux-next$ ./scripts/get_maintainer.pl  include/linux/regmap.h
Mark Brown <broonie@kernel.org> (supporter:REGISTER MAP ABSTRACTION)
linux-kernel@vger.kernel.org (open list:REGISTER MAP ABSTRACTION)



Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
