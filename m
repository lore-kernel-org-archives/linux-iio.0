Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC703EBF39
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769883734; cv=none; b=nC/nvzpYptTo1wROxf9Ms+8RWeBGM3c8wgXBRGv5ExGMyXEAW0MdOLCLgYVsDfhubtUzFlp/X6iZxySKpzFj6b1i5SL43WIbZZjzdnWqBg+w1sVffZEvXXUQXDHG4cI8tV6lW/vVt082A1Rll5ANVrwUWILVoMOm7l83zEALT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769883734; c=relaxed/simple;
	bh=Xg0AZJ0Qv2Njmrx0kB8BwI3/jdyqbYtTyraOMga2K7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xv5pUkP2VpS8jA0HTdA7UJPWSxVKtsdXI+k4FgesO8G006zBVwOozNSiME7hwNxrI4nLtcJOydcU4yVOIyox/VsSsl+BVw5T/BRZxeCgnVoLePIW/7/Z2rNSYCwfH30jCYgysAhk4Z1/H+6+I5E38854D/3w1HY2j8bW54aZfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7G1HbGE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7G1HbGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D062AC4CEF1;
	Sat, 31 Jan 2026 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769883734;
	bh=Xg0AZJ0Qv2Njmrx0kB8BwI3/jdyqbYtTyraOMga2K7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D7G1HbGE8olib+/j/P63iqa/i3gWK4pITTtUoD4O3wACoURPS+cGpRj/H1cn3+yoK
	 WwnYrhihmluF2JPj5Bqhkw+DelpwN810T7FrH556ab5brcBxnM60QfcpJ65GA2IUQs
	 FYhrHkkVmj03nWpIQlrJ34TvZ6AjAdHOhsArlgDH2lPAa2lPlJr6Zzbk/OWdTtlafd
	 G/EXA0lzc+cnakX+z1dlhLZW+lB5Z8UpiIQgMvckUCskUaNsZqCW9ijQgg5rntlKo5
	 Y0eero+jInBLnYh17rNM/msB2l57JUcrQ/BO8au7EBxNNIiNz3b4UXQT8I4GNIYQmG
	 LO/EIVuKkcRhQ==
Date: Sat, 31 Jan 2026 18:22:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: andy@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 krzk+dt@kernel.org, linux-iio@vger.kernel.org, nuno.sa@analog.com,
 robh@kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: iio: gyroscope: bosch,bmg160: add
 bmx055 gyroscope binding
Message-ID: <20260131182205.5b851204@jic23-huawei>
In-Reply-To: <20260130022452.408784-1-jerrysteve1101@gmail.com>
References: <20260129184621.749d6450@jic23-huawei>
	<20260130022452.408784-1-jerrysteve1101@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 10:24:52 +0800
Jun Yan <jerrysteve1101@gmail.com> wrote:

> > On Thu, 29 Jan 2026 15:11:01 +0800
> > Jun Yan <jerrysteve1101@gmail.com> wrote:
> >   
> > > Add the device-tree binding for the bosch BMX055 IMU (gyroscope part).
> > > 
> > > Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
> > > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>  
> > 
> > Hi Jun,
> > 
> > Is there anything stopping the use of fallback compatibles? 
> > It seems from the driver that even the chip ID matches.
> > 
> > That is, can we have
> > compatible = 'bosch,bmx055_gyro', 'bosch,bmg160'.
> > 
> > or something like that (I can't remember exact syntax) so that
> > if we have a newer DT, it will work on an older kernel?  
> Yes, using fallback compatibles is a better approach. So from my
> understanding, it should be modified to:
> 
> properties:                                                                                
>   compatible:                                                                              
>     oneOf:                                                                                 
>       - const: bosch,bmg160                                                                
>       - items:                                                                             
>         - enum:                                                                            
>           - bosch,bmg160                                                                   
>           - bosch,bmi055_gyro                                                              
>           - bosch,bmi088_gyro                                                              
>           - bosch,bmx055_gyro                                                              
>         - const: bosch,bmg160
> 
> Or in a similar format?
> 
> And drop the change in the driver?
Explicit matching can still be a good idea so we name things
correctly etc, but this driver doesn't bother so indeed
there shouldn't need to be a change.

Whether to add only the new device with the fallback is
a question to the dt-maintainers. We'd also need to check
if any DT files in tree need an update for that.

Jonathan

> 
> Best Regrads,
> 
> Jun Yan
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml          | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > > index 3c6fe74af0b8..907fca4e5895 100644
> > > --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> > > @@ -15,6 +15,7 @@ properties:
> > >        - bosch,bmg160
> > >        - bosch,bmi055_gyro
> > >        - bosch,bmi088_gyro
> > > +      - bosch,bmx055_gyro
> > >  
> > >    reg:
> > >      maxItems: 1  
> 
> 
> 

