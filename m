Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50307 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933067AbcHYIDo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2016 04:03:44 -0400
Subject: Re: [PATCH v2] iio: dac: AD8801: add Analog Devices AD8801/AD8803
 support
To: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        linux-iio@vger.kernel.org
References: <20160824144420.7326-1-gwenhael.goavec-merou@trabucayre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Paul Cercueil <paul.cercueil@analog.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0177ce8f-4bc2-a726-1503-6786a14f3148@metafoo.de>
Date: Thu, 25 Aug 2016 10:02:42 +0200
MIME-Version: 1.0
In-Reply-To: <20160824144420.7326-1-gwenhael.goavec-merou@trabucayre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/24/2016 04:44 PM, Gwenhael Goavec-Merou wrote:
> Add support for Analog Devices AD8801/AD8803, 8 channels 8bits, Digital to
> Analog converters.
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>

Looks good, thanks.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Just one tiny thing, there is a extra new line at the end of the file. But
maybe Jonathan can remove that if he replies the patch.
