Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34991 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbbHWWc5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Aug 2015 18:32:57 -0400
MIME-Version: 1.0
In-Reply-To: <1440099488-4850-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1440099421-4762-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1440099488-4850-1-git-send-email-vladimir.barinov@cogentembedded.com>
From: Rob Herring <robherring2@gmail.com>
Date: Sun, 23 Aug 2015 17:32:37 -0500
Message-ID: <CAL_JsqJHT+s_+cDw5h2Ra7uh+4bHsGKXN-o0GAQ1DS_HdfWg7w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt: Add vendor prefix 'holt'
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Cory Tusar <cory.tusar@pid1solutions.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 20, 2015 at 2:38 PM, Vladimir Barinov
<vladimir.barinov@cogentembedded.com> wrote:
> Add Holt Integrated Circuits, Inc. to the list of device tree vendor
> prefixes
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Changes in version 2:
> - none
> Changes in version 3:
> - none
> Changes in version 4:
> - none
>
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index d444757..bc64cc9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -99,6 +99,7 @@ himax Himax Technologies, Inc.
>  hisilicon      Hisilicon Limited.
>  hit    Hitachi Ltd.
>  hitex  Hitex Development Tools
> +holt   Holt Integrated Circuits, Inc.
>  honeywell      Honeywell
>  hp     Hewlett Packard
>  i2se   I2SE GmbH
> --
> 1.9.1
>
