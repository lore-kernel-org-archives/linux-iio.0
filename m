Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C5C636CC
	for <linux-iio@archiver.kernel.org>; Mon, 20 Feb 2023 11:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjBTL2R (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 Feb 2023 06:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBTL2Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2023 06:28:16 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF9729EFE
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2023 03:28:13 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 9AA02DF00A8; Mon, 20 Feb 2023 12:28:11 +0100 (CET)
Date:   Mon, 20 Feb 2023 12:28:11 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: discard samples during filters
        settling time
Message-ID: <20230220112811.GA25621@frolo.macqel>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org> <20230218135622.6c5d4569@jic23-huawei> <Y/M5feqZB+4JP99M@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/M5feqZB+4JP99M@lore-desk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lorenzo and Jonathan,

On Mon, Feb 20, 2023 at 10:12:29AM +0100, Lorenzo Bianconi wrote:
> On Sat, Feb 18, 2023 at 01:56:22PM +0000, Jonathan Cameron wrote:
> 
> > On Wed,  8 Feb 2023 15:42:31 +0100
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > 
> > > During digital filters settling time the driver is expected to drop
> > > samples since they can be corrupted. Introduce the capability to drop
> > > a given number of samples according to the configured ODR.
> > > Add the sample_to_discard data for LSM6DSM sensor.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > Is this only necessary for the particular sensor you have provided
> > values for?  Or is it more general?
> > 
> > I think the code will currently just set the number of samples to discard
> > to 0 for other cases (as no value set for those sensor types).
> > That's fine if 0 is definitely the right value for those other sensors.
> 
>  I think all the sensors have this information in the datasheet/application
>  note. However, even if we add sample_to_discard just for LSM6DSM for the moment,
>  we do not introduce any regression for the other sensors with respect to the
>  previous codebase since sample_to_discard will be just set to 0 (so we do not
>  discard any sample). I can add sample_to_discard for LSM6DSO but at the
>  moment I do not have other devices for testing.
>  For LSM6DSO, do you prefer to add it in v2 or is it fine a follow-up patch?

How comes your patch really drops samples on my st,ism330dlc IMU ?

Best regards

Philippe
