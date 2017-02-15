Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34164 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdBOW5E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2017 17:57:04 -0500
Date: Wed, 15 Feb 2017 16:57:02 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 09/10] dt-bindings: mux-adg792a: document devicetree
 bindings for ADG792A/G mux
Message-ID: <20170215225702.mzmtubeymegbhdnp@rob-hp-laptop>
References: <1486568517-6997-1-git-send-email-peda@axentia.se>
 <1486568517-6997-10-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486568517-6997-10-git-send-email-peda@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 08, 2017 at 04:41:56PM +0100, Peter Rosin wrote:
> Analog Devices ADG792A/G is a triple 4:1 mux.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/mux/adi,adg792a.txt        | 75 ++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mux/adi,adg792a.txt

Reviewed-by: Rob Herring <robh@kernel.org> 
