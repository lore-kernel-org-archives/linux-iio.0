Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58910 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBDM1e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Feb 2017 07:27:34 -0500
Subject: Re: [PATCH 5/5] Documentation: dt: iio: imu: st_lsm6dsx: add lsm6ds3h
 sensor device binding
To: Rob Herring <robh@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20170129104928.15533-1-lorenzo.bianconi@st.com>
 <20170129104928.15533-6-lorenzo.bianconi@st.com>
 <20170201160604.4vlnxdiot6by5wxd@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9e16f2c9-936c-a1b9-a36e-dabe5fc89909@kernel.org>
Date: Sat, 4 Feb 2017 12:27:32 +0000
MIME-Version: 1.0
In-Reply-To: <20170201160604.4vlnxdiot6by5wxd@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/17 16:06, Rob Herring wrote:
> On Sun, Jan 29, 2017 at 11:49:28AM +0100, Lorenzo Bianconi wrote:
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> ---
>>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>>  1 file changed, 1 insertion(+)
> 
> This could be combined with patch 3.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
Yeah, whilst it's normally one change one patch, this series did
seem to break things up a little excessively!  Perhaps 3 patches would
have be ideal.

1) Supporting refactor of code
2) New device support
3) DT for new devices.

Meh however.  Good easy series for me to handle so I'm happy
anyway ;)

Applied to the togreg branch of iio.git and pushed out as testing.

Chances are high that this is too late for the coming merge windows - all depends
on how fed up Linus is feeling tomorrow!

Jonathan
