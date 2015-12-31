Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58369 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbbLaWRf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 31 Dec 2015 17:17:35 -0500
Date: Thu, 31 Dec 2015 16:17:31 -0600
From: Rob Herring <robh@kernel.org>
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	jic23@kernel.org
Subject: Re: [PATCH v2] iio: health: max30100: add config for LED current
Message-ID: <20151231221731.GA4445@rob-hp-laptop>
References: <1451454288-9945-1-git-send-email-mranostay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1451454288-9945-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Dec 29, 2015 at 09:44:48PM -0800, Matt Ranostay wrote:
> Allow the current for both RED and IR LEDs to be set via an device tree
> property setting.
> 
> This is an optional setting that is useful for applications that have a
> known glass attenuation factor.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
> Changes from v2:
> * change to use microamp property name from LED class
> * updated documentation for new format
> * added allowed current index map
> 
> .../devicetree/bindings/iio/health/max30100.txt    |  8 +++
>  drivers/iio/health/max30100.c                      | 81 ++++++++++++++++++++--
>  2 files changed, 83 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
