Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753116AbdICQ4J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 12:56:09 -0400
Date: Sun, 3 Sep 2017 17:56:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: pressure: add LPS33HW and LPS35HW
 device bindings
Message-ID: <20170903175606.0c945a5f@archlinux>
In-Reply-To: <20170902173915.17341-3-lorenzo.bianconi@st.com>
References: <20170902173915.17341-1-lorenzo.bianconi@st.com>
        <20170902173915.17341-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  2 Sep 2017 19:39:15 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Obviously an Ack from devicetree side fo things is welcome, but
given how trivial this is probably unnecessary!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index be64357808d0..9cfc82d21792 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -72,3 +72,5 @@ Pressure sensors:
>  - st,lps25h-press
>  - st,lps331ap-press
>  - st,lps22hb-press
> +- st,lps33hw
> +- st,lps35hw

