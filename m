Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeETKY1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 06:24:27 -0400
Date: Sun, 20 May 2018 11:24:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Peter Rosin <peda@axentia.se>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH trivial] dt-bindings: iio: afe: Spelling
 s/mesaurement/measurement/
Message-ID: <20180520112421.2b71cfa5@archlinux>
In-Reply-To: <1526389584-19835-1-git-send-email-geert+renesas@glider.be>
References: <1526389584-19835-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 15 May 2018 15:06:24 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt | 2 +-
>  Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
> index 0ddbaebba8ceca13..821b61b8c542ff92 100644
> --- a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
> +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
> @@ -2,7 +2,7 @@ Current Sense Amplifier
>  =======================
>  
>  When an io-channel measures the output voltage from a current sense
> -amplifier, the interesting mesaurement is almost always the current
> +amplifier, the interesting measurement is almost always the current
>  through the sense resistor, not the voltage output. This binding
>  describes such a current sense circuit.
>  
> diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
> index 8e7b3e408a5253c5..0f67108a07b6327b 100644
> --- a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
> +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
> @@ -2,7 +2,7 @@ Current Sense Shunt
>  ===================
>  
>  When an io-channel measures the voltage over a current sense shunt,
> -the interesting mesaurement is almost always the current through the
> +the interesting measurement is almost always the current through the
>  shunt, not the voltage over it. This binding describes such a current
>  sense circuit.
>  

