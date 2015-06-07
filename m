Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47914 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbFGQta (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 12:49:30 -0400
Message-ID: <55747616.1010901@kernel.org>
Date: Sun, 07 Jun 2015 17:49:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Xander Huff <xander.huff@ni.com>, lars@metafoo.de,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	ben.shelton@ni.com, joshc@ni.com, joe.hershberger@ni.com
Subject: Re: [PATCH v2 2/2] iio: adc: xilinx-xadc: Add label as an optional
 argument for aux channels
References: <555B78A3.2030202@metafoo.de> <1432135352-29848-1-git-send-email-xander.huff@ni.com> <1432135352-29848-2-git-send-email-xander.huff@ni.com>
In-Reply-To: <1432135352-29848-2-git-send-email-xander.huff@ni.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/15 16:22, Xander Huff wrote:
> To better facilitate user-mode access to optional aux channels, allow
> device trees to specify a custom label for defined channels.
> 
> Signed-off-by: Xander Huff <xander.huff@ni.com>
> Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
> Reviewed-by: Josh Cartwright <joshc@ni.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index ce93bd8..bda4241 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1119,6 +1119,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  			if (ret || reg > 16)
>  				continue;
>  
> +			of_property_read_string(child, "label",
> +						&chan->extend_name);
> +
>  			if (of_property_read_bool(child, "xlnx,bipolar"))
>  				chan->scan_type.sign = 's';
>  
> 
I think what Lars was suggesting was a change to the IIO side of this rather than
just changing the device tree binding.  Perhaps an additional per channel attribute
called _label which would allow for board specific labelling?
