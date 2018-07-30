Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:54321 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeG3XXN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jul 2018 19:23:13 -0400
Date: Mon, 30 Jul 2018 15:46:13 -0600
From: Rob Herring <robh@kernel.org>
To: Siddartha Mohanadoss <smohanad@codeaurora.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add DT binding document
 for PMIC5 ADC
Message-ID: <20180730214613.GA24177@rob-hp-laptop>
References: <1532562248-6810-1-git-send-email-smohanad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532562248-6810-1-git-send-email-smohanad@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 25, 2018 at 04:44:08PM -0700, Siddartha Mohanadoss wrote:
> PMIC5 ADC has support for clients to measure voltage and current
> on inputs connected to the PMIC. Clients include reading voltage
> phone power and on board system thermistors for thermal management.
> ADC5 on certain PMIC has support to read battery current.
> 
> This change adds documentation.
> 
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  77 ++++++++++----
>  include/dt-bindings/iio/qcom,spmi-vadc.h           | 115 ++++++++++++++++++++-
>  2 files changed, 172 insertions(+), 20 deletions(-)

Please add acks/reviewed-bys when posting new versions.

Rob
