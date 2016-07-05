Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35879 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbcGEQHQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2016 12:07:16 -0400
Date: Tue, 5 Jul 2016 11:07:12 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Samu Onkalo <samu.onkalo@intel.com>
Subject: Re: [PATCH 1/2 v2] iio: magn: DT bindings for AK8974
Message-ID: <20160705160712.GA16327@rob-hp-laptop>
References: <1467623287-9877-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467623287-9877-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 04, 2016 at 11:08:06AM +0200, Linus Walleij wrote:
> This adds device tree bindings for the AK8974 magnetometer, similar
> to those for the AK8975.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - No changes, just reposting to keep together with the series
> ---
>  .../bindings/iio/magnetometer/ak8974.txt           | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt

Acked-by: Rob Herring <robh@kernel.org>
