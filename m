Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41533 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732513AbeGaVms (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jul 2018 17:42:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so6611566pfn.8
        for <linux-iio@vger.kernel.org>; Tue, 31 Jul 2018 13:00:53 -0700 (PDT)
Date: Wed, 1 Aug 2018 01:30:39 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Maxime =?iso-8859-1?Q?Roussin-B=E9langer?=
        <maxime.roussinbelanger@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: si1133: fix uninitialized resp variable
Message-ID: <20180731200039.GA31053@himanshu-Vostro-3559>
References: <20180731192651.29128-1-maxime.roussinbelanger@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180731192651.29128-1-maxime.roussinbelanger@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 31, 2018 at 03:26:51PM -0400, Maxime Roussin-Bélanger wrote:
> Read response register to detect any error.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Missing Signed-off-by: ?

Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
