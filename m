Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:39032 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932959AbaKMOeY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Nov 2014 09:34:24 -0500
MIME-Version: 1.0
In-Reply-To: <1415888044-16635-4-git-send-email-ezequiel.garcia@imgtec.com>
References: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com> <1415888044-16635-4-git-send-email-ezequiel.garcia@imgtec.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 13 Nov 2014 08:34:01 -0600
Message-ID: <CAL_JsqJdPb=QjpgvYxCS1MGtWX6YbDobMJ9VBG7-xO9q-69G-Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] DT: Add a vendor prefix for Cosmic Circuits
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Andrew Bresticker <abrestic@chromium.org>,
	James Hartley <james.hartley@imgtec.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Naidu.Tellapati@imgtec.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 13, 2014 at 8:14 AM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 723999d..1bfa13a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -35,6 +35,7 @@ chrp  Common Hardware Reference Platform
>  chunghwa       Chunghwa Picture Tubes Ltd.
>  cirrus Cirrus Logic, Inc.
>  cortina        Cortina Systems, Inc.
> +cosmic Cosmic Circuits
>  crystalfontz   Crystalfontz America, Inc.
>  dallas Maxim Integrated Products (formerly Dallas Semiconductor)
>  davicom        DAVICOM Semiconductor, Inc.
> --
> 2.1.0
>
