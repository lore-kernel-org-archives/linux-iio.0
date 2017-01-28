Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45357 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdA1MoX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 07:44:23 -0500
Subject: Re: [PATCH v2 2/2] Documentation: dt: iio: imu: st_lsm6dsx: add
 st,drdy-int-pin property
To: Rob Herring <robh@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170122183225.2539-1-lorenzo.bianconi@st.com>
 <20170122183225.2539-3-lorenzo.bianconi@st.com>
 <20170123204511.4u3tjhyqg5sdrzbb@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cde9164e-9ecb-71d4-35ce-435c0b26e722@kernel.org>
Date: Sat, 28 Jan 2017 12:43:20 +0000
MIME-Version: 1.0
In-Reply-To: <20170123204511.4u3tjhyqg5sdrzbb@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/01/17 20:45, Rob Herring wrote:
> On Sun, Jan 22, 2017 at 07:32:25PM +0100, Lorenzo Bianconi wrote:
>> Add st,drdy-int-pin property to select interrupt pin of the package
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> ---
>>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
Applied

Thanks,
Jonathan
