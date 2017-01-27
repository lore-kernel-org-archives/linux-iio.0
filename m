Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35451 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdA0TjT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 14:39:19 -0500
Date: Fri, 27 Jan 2017 13:39:17 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 07/12] dt-bindings: i2c: i2c-mux-simple: document
 i2c-mux-simple bindings
Message-ID: <20170127193917.6xuunrkjkqh4f2v7@rob-hp-laptop>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-8-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484755035-25927-8-git-send-email-peda@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 18, 2017 at 04:57:10PM +0100, Peter Rosin wrote:
> Describe how a generic multiplexer controller is used to mux an i2c bus.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/i2c/i2c-mux-simple.txt     | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
> new file mode 100644
> index 000000000000..253d5027843b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
> @@ -0,0 +1,81 @@
> +Simple I2C Bus Mux
> +
> +This binding describes an I2C bus multiplexer that uses a mux controller
> +from the mux subsystem to route the I2C signals.
> +
> +                                  .-----.  .-----.
> +                                  | dev |  | dev |
> +    .------------.                '-----'  '-----'
> +    | SoC        |                   |        |
> +    |            |          .--------+--------'
> +    |   .------. |  .------+    child bus A, on MUX value set to 0
> +    |   | I2C  |-|--| Mux  |
> +    |   '------' |  '--+---+    child bus B, on MUX value set to 1
> +    |   .------. |     |    '----------+--------+--------.
> +    |   | MUX- | |     |               |        |        |
> +    |   | Ctrl |-|-----+            .-----.  .-----.  .-----.
> +    |   '------' |                  | dev |  | dev |  | dev |
> +    '------------'                  '-----'  '-----'  '-----'
> +
> +Required properties:
> +- compatible: i2c-mux-simple,mux-locked or i2c-mux-simple,parent-locked

Not a fan of using "simple" nor the ','. Perhaps lock type should be 
separate property.

I'm not sure I get the mux vs. parent locked fully. How do I determine 
what type I have? We already have bindings for several types of i2c 
muxes. How does the locking annotation fit into those?

Rob
