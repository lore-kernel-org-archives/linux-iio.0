Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbdKSO56 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 09:57:58 -0500
Date: Sun, 19 Nov 2017 14:57:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
Cc: Harinath Nampally <harinath922@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH v4 1/2] iio: accel: mma8452: Rename a struct for code
 readibility
Message-ID: <20171119145754.054e2791@archlinux>
In-Reply-To: <7bb1626f-6071-753e-cb7d-885d9e293e43@posteo.de>
References: <1509904804-4608-1-git-send-email-harinath922@gmail.com>
        <1509904804-4608-2-git-send-email-harinath922@gmail.com>
        <7bb1626f-6071-753e-cb7d-885d9e293e43@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 5 Nov 2017 21:36:25 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> On 2017-11-05 19:00, Harinath Nampally wrote:
> > Rename time step look up struct to generic name
> > as the values in the look table are same for all
> > the other events like pulse, transient etc.
> > 
> > Signed-off-by: Harinath Nampally <harinath922@gmail.com>  
> 
> Acked-by: Martin Kepplinger <martink@posteo.de>
> 

Applied.
