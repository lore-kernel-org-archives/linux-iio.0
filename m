Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbdB0ReH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Feb 2017 12:34:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170219145949.22750-1-tduszyns@gmail.com>
References: <20170219145949.22750-1-tduszyns@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Feb 2017 11:33:32 -0600
Message-ID: <CAL_JsqKpb=jSqb84nZSfpY2J-b=H4u+6T2+O7Yi01UwLX+vsRQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] of: add vendor prefix for Sensirion company
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 19, 2017 at 8:59 AM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
> This patch adds prefix for Sensirion company.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

There's another patch already adding this that I'm applying, so drop this one.

Rob
