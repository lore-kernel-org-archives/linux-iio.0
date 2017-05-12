Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34547 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753488AbdELTkC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 May 2017 15:40:02 -0400
Date: Fri, 12 May 2017 14:40:00 -0500
From: Rob Herring <robh@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: as3935: noise detection + threshold
 changes
Message-ID: <20170512194000.wbxf22kqfmp6k5l6@rob-hp-laptop>
References: <20170508015041.10285-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170508015041.10285-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 07, 2017 at 06:50:41PM -0700, Matt Ranostay wrote:
> Most applications are too noisy to allow the default noise and
> watchdog settings, and thus need to be configurable via DT
> properties.
> 
> Also default settings to POR defaults on a reset, and register
> distuber interrupts as noise since it prevents proper usage.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  .../devicetree/bindings/iio/proximity/as3935.txt   |  6 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/proximity/as3935.c                     | 43 ++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 3 deletions(-)
