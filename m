Return-Path: <SRS0=wBHN=5O=gmail.com=robherring2@kernel.org>
Date: Fri, 9 Jun 2017 09:18:16 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: Re: [PATCH 2/2] Documentation: dt: iio: imu: st_lsm6dsx: support
 active-low interrupts
Message-ID: <20170609141816.jllbisljifdj4vhr@rob-hp-laptop>
References: <20170607181711.16195-1-lorenzo.bianconi@st.com>
 <20170607181711.16195-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170607181711.16195-3-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 07, 2017 at 08:17:11PM +0200, Lorenzo Bianconi wrote:
> Update st_lsm6dsx device binding with active-low interrupts support
> (IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING).
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

"dt-bindings: iio: ..." is preferred for subject. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
