Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34710 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbdJMVyk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Oct 2017 17:54:40 -0400
Date: Fri, 13 Oct 2017 16:54:38 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: health: Fix max30100 I2C chip
 address in example
Message-ID: <20171013215438.fqb3qvevxmwb6i2z@rob-hp-laptop>
References: <1507712948-29300-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507712948-29300-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 11, 2017 at 11:09:07AM +0200, Peter Meerwald-Stadler wrote:
> Should be in hex, not decimal or even octal
> 
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> ---
>  Documentation/devicetree/bindings/iio/health/max30100.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

