Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42386 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250AbcHORzY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 13:55:24 -0400
Subject: Re: [PATCH v2 1/2] devicetree: bindings: Add vendor prefix for
 Domintech Co., Ltd.
To: Aleksei Mamlin <mamlinav@gmail.com>
References: <1469460078-6460-1-git-send-email-mamlinav@gmail.com>
 <1469460078-6460-2-git-send-email-mamlinav@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f1bbdbb4-914d-b15b-c08c-76af8fa4d555@kernel.org>
Date: Mon, 15 Aug 2016 18:55:21 +0100
MIME-Version: 1.0
In-Reply-To: <1469460078-6460-2-git-send-email-mamlinav@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/07/16 16:21, Aleksei Mamlin wrote:
> Add vendor-prefix for Domintech Co., Ltd.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git

Thanks

Jonathan
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2c2500d..7363916 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -75,6 +75,7 @@ digilent	Diglent, Inc.
>  dlg	Dialog Semiconductor
>  dlink	D-Link Corporation
>  dmo	Data Modul AG
> +domintech	Domintech Co., Ltd.
>  dptechnics	DPTechnics
>  dragino	Dragino Technology Co., Limited
>  ea	Embedded Artists AB
> 

