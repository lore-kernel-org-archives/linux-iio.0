Return-Path: <SRS0=53Ys=ZF=gmail.com=robherring2@kernel.org>
Date: Mon, 23 Jan 2017 14:45:11 -0600
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 2/2] Documentation: dt: iio: imu: st_lsm6dsx: add
 st,drdy-int-pin property
Message-ID: <20170123204511.4u3tjhyqg5sdrzbb@rob-hp-laptop>
References: <20170122183225.2539-1-lorenzo.bianconi@st.com>
 <20170122183225.2539-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170122183225.2539-3-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 22, 2017 at 07:32:25PM +0100, Lorenzo Bianconi wrote:
> Add st,drdy-int-pin property to select interrupt pin of the package
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
