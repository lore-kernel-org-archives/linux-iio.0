Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33132 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdBPCLG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2017 21:11:06 -0500
Date: Wed, 15 Feb 2017 20:11:04 -0600
From: Rob Herring <robh@kernel.org>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v2 4/4] iio: chemical: add dsm501 particle sensor driver
 bindings
Message-ID: <20170216021104.i22knp35kaiytxxs@rob-hp-laptop>
References: <20170209171252.4802-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209171252.4802-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 09, 2017 at 06:12:52PM +0100, Tomasz Duszynski wrote:
> This patch adds bindings for dsm501 particle sensor driver.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  Changes in v2:
>   o add 'data' prefix to gpios property
> 
>  .../devicetree/bindings/iio/chemical/dsm501.txt          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/dsm501.txt

Acked-by: Rob Herring <robh@kernel.org>
