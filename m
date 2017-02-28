Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36621 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdB1AQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 19:16:34 -0500
Date: Mon, 27 Feb 2017 18:09:00 -0600
From: Rob Herring <robh@kernel.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] [RFC] iio: dht11: Add optional support for supply
 control via regulator framework
Message-ID: <20170228000900.sn2wnpzbtjup3wz5@rob-hp-laptop>
References: <1487869613-11927-1-git-send-email-harald@ccbib.org>
 <1487869613-11927-2-git-send-email-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487869613-11927-2-git-send-email-harald@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 23, 2017 at 05:06:53PM +0000, Harald Geyer wrote:
> If a supply is provided via DT, release the supply whenever we don't read
> the sensor. Also use notifications to track the actual status of the
> supply to ensure that we meet the timing requirements stated in the
> datasheet.
> 
> This change is motivated by the hope that these sensors will work more
> reliably if power-cycled regularly.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> This is an RFC this time, because I want to run extensive long term tests
> with DHT11 and DHT22 before officially proposing this for inclusion. I
> have learned my lessons with this quirky bits of HW... :(
> 
> However since this will take a lot of time (mostly physical, but also
> man hours), I'd like to get review comments now instead of risking a
> second iteration of long term tests.
> 
>  .../devicetree/bindings/iio/humidity/dht11.txt     | 10 ++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/humidity/dht11.c                       | 57 ++++++++++++++++++++--
>  2 files changed, 64 insertions(+), 3 deletions(-)
