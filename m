Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33297 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753664AbdBARon (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2017 12:44:43 -0500
Date: Wed, 1 Feb 2017 11:44:36 -0600
From: Rob Herring <robh@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org, dledford@redhat.com,
        akpm@linux-foundation.org, shraddha.6596@gmail.com, w@1wt.eu,
        balbi@kernel.org, mtk.manpages@gmail.com, sjenning@redhat.com,
        ksenija.stanojevic@gmail.com, vilhelm.gray@gmail.com,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: distance: add dt binding for devantech-srf04
Message-ID: <20170201174436.6p5hdis2rvpqus6g@rob-hp-laptop>
References: <20170131180306.GA12880@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170131180306.GA12880@andreas>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 31, 2017 at 07:03:06PM +0100, Andreas Klinger wrote:
> This patch adds dt binding for devantech ultrasonic ranger srf04.
> 
> The vendor "devantech" was already added to the vendor list with
>         "[PATCH v4 1/3] iio: distance: srf08: add trivial DT binding"
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/devantech-srf04.txt     | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt

Acked-by: Rob Herring <robh@kernel.org>
