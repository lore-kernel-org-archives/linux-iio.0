Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34662 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdGKCtk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jul 2017 22:49:40 -0400
Date: Mon, 10 Jul 2017 21:49:36 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH 6/9] dt-bindings: iio: humidity: hts221: support
 active-low interrupts
Message-ID: <20170711024936.3jncjvrx37g4herl@rob-hp-laptop>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
 <20170709165704.26311-7-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170709165704.26311-7-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 09, 2017 at 06:57:01PM +0200, Lorenzo Bianconi wrote:
> Update hts221 device binding with active-low interrupts support
> (IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING).
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  Documentation/devicetree/bindings/iio/humidity/hts221.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
