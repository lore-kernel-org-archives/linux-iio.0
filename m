Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36287 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754937AbdFWUn1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jun 2017 16:43:27 -0400
Date: Fri, 23 Jun 2017 15:43:25 -0500
From: Rob Herring <robh@kernel.org>
To: Michael Stecklein <m-stecklein@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: humidity: add bindings for
 HDC100x sensors
Message-ID: <20170623204325.w3sxqfsjf42exs3z@rob-hp-laptop>
References: <1497888066-12652-1-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497888066-12652-1-git-send-email-m-stecklein@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 19, 2017 at 11:01:04AM -0500, Michael Stecklein wrote:
> Add the bindings for the family of HDC100x sensors.
> 
> Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
> ---
>  .../devicetree/bindings/iio/humidity/hdc100x.txt        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/hdc100x.txt

Acked-by: Rob Herring <robh@kernel.org>

