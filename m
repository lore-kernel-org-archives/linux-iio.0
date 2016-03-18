Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53790 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbcCRTvJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 18 Mar 2016 15:51:09 -0400
Date: Fri, 18 Mar 2016 14:51:05 -0500
From: Rob Herring <robh@kernel.org>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: ad5755: Add DT binding documentation
Message-ID: <20160318195105.GA18899@rob-hp-laptop>
References: <1457705561-12253-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1457705561-12253-2-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457705561-12253-2-git-send-email-sean.nyekjaer@prevas.dk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 11, 2016 at 03:12:41PM +0100, Sean Nyekjaer wrote:
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
> Changes since v4:
> - Appended -hz to dc-dc-freq
> - Added adi,dc-dc-max-microvolt
> - Added reg property
> 
> Changes since v3:
> - replaced '_' with '-'
> - Now used actual values instead of register values.
> 
> Changes since v2:
>  - Removed defines, alot easier to read
> 
>  .../devicetree/bindings/iio/dac/ad5755.txt         | 124 +++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5755.txt

Acked-by: Rob Herring <robh@kernel.org>
