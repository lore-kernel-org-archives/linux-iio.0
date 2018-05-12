Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeELKDo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 06:03:44 -0400
Date: Sat, 12 May 2018 11:03:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] iio: potentiostat: lmp91000: add LMP91002 support
Message-ID: <20180512110339.4992392b@archlinux>
In-Reply-To: <20180508154256.GA28095@rob-hp-laptop>
References: <20180508053401.32485-1-matt.ranostay@konsulko.com>
        <20180508154256.GA28095@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 8 May 2018 10:42:56 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, May 07, 2018 at 10:34:01PM -0700, Matt Ranostay wrote:
> > LMP91002 is register compatible so add devicetree and i2c client ids
> > 
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> > 
> > Changes from v1:
> > * Split out compatible options in multiple lines for the lmp91000.txt documentation
> > 
> >  Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt | 9 ++++++---
> >  drivers/iio/potentiostat/lmp91000.c                             | 2 ++
> >  2 files changed, 8 insertions(+), 3 deletions(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

