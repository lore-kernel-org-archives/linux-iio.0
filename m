Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:32797 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbdARUEH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 15:04:07 -0500
Date: Wed, 18 Jan 2017 13:54:55 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] DT/bindings: Add bindings for TI ADS7950 A/DC chips
Message-ID: <20170118195455.ckwp677vxgsrqkbp@rob-hp-laptop>
References: <1484157171-15571-1-git-send-email-david@lechnology.com>
 <1484157171-15571-2-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484157171-15571-2-git-send-email-david@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 11, 2017 at 11:52:49AM -0600, David Lechner wrote:
> This adds device tree bindings for the TI ADS7950 family of A/DC chips.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../devicetree/bindings/iio/adc/ti-ads7950.txt     | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt

Acked-by: Rob Herring <robh@kernel.org>
