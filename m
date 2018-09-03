Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39872 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeICQL2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Sep 2018 12:11:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so364158wrf.6
        for <linux-iio@vger.kernel.org>; Mon, 03 Sep 2018 04:51:39 -0700 (PDT)
Date: Mon, 3 Sep 2018 13:51:36 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: take into account ts samples in wm
 configuration
Message-ID: <20180903115136.GA4992@localhost.localdomain>
References: <cover.1535705166.git.lorenzo.bianconi@redhat.com>
 <20180830203859.6527-1-lorenzo.bianconi@redhat.com>
 <20180902211942.4922c0ec@archlinux>
 <20180903094853.00004152@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180903094853.00004152@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On Sun, 2 Sep 2018 21:19:42 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu, 30 Aug 2018 22:38:59 +0200
> > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
> > 
> > > Take into account hw timer samples in pattern length computation used
> > > in st_lsm6dsx_update_watermark routine for watermark configuration
> > > 
> > > Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>  
> > Applied to the fixes-togreg branch of iio.git and marked for stable.
> > 
> Oops. I actually applied V2 and replied to the wrong email.
> 

No worries, I had already double-checked :)

Regards,
Lorenzo
