Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1E2F8BEE;
	Thu,  5 Feb 2026 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770321829; cv=none; b=NTuym+fIG8raHHydSPq2eFPiLFZND2pTUpkq5W1kCmv7PhQ2ho5A+hQqIJHDy+kZTZ2qba4TOXcyUAHlQqTfuA6l8rFfAaIy8BVM9zTSR9sRXRHkLkBMaFtE+//wvCIkCQ/vt79gbvh+l0etRvZDApVrGwp7Cch/BAT1EB5wbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770321829; c=relaxed/simple;
	bh=sPI79Qel7Vl+Wlp77/drE/1MWI5Nrcgrlsyl9jcGNsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHnT3sEkglN1t4qjIchqlVrDepN8AuLk8KFVEzIUyqBMpcs4e6PnUPeRy/WrQYlms1Dya8tQSVWQEBXZY1RyjH00aQfEGgDZ1vMsYOTPGEr0UpljhTUweFttXa7bzQvOxG6DSBYQ54tZdqNZWNs+DVUB4Nof7R8VC9Vaurq0kF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrskbwsj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrskbwsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE23C4CEF7;
	Thu,  5 Feb 2026 20:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770321828;
	bh=sPI79Qel7Vl+Wlp77/drE/1MWI5Nrcgrlsyl9jcGNsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xrskbwsj0y0OC8PzZQ2nVPOIyI+G2lvlVimYlACW2HYausYVF7+EOZI8ebvJewxw9
	 8IiFumi8EovYk+JY0/2Ci/bqV4XTDQBMXc47uV0HJaGnl958a0xo78KEq8+xDm/RGh
	 ggZeIhuC0PvfkvZDW+FtHpdywQL7JKDo9H6av5e2W4U6Wcbkw6geiwk+IMquoq0DCB
	 NxeMPJiX0kOC1jcLEQrgEMFre3wd2j+n3sKHkx8ARwfE3hHv5iq6hAYuwD0eGZxhFu
	 p2A96jl9kpymRPpkmmHl0xYA742Sp8+to3fAK43EKKeZL0QONX6/AmAlSxDlhKKev1
	 fa1qeSxv5RiRw==
Date: Thu, 5 Feb 2026 20:03:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: ABI: fix current_trigger description
Message-ID: <20260205200340.0f343ceb@jic23-huawei>
In-Reply-To: <db6c8834-7236-429a-bbf3-27c699f69470@baylibre.com>
References: <20260204180202.515393-1-cosmin-gabriel.tanislav.xa@renesas.com>
	<d297fa4d-c8fe-4ec9-91dc-e15125adc711@baylibre.com>
	<TYRPR01MB1561962BEB21FDF013F18FB9B8598A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
	<db6c8834-7236-429a-bbf3-27c699f69470@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 13:55:33 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/4/26 1:50 PM, Cosmin-Gabriel Tanislav wrote:
> >> From: David Lechner <dlechner@baylibre.com>
> >> Sent: Wednesday, February 4, 2026 9:44 PM
> >>
> >> On 2/4/26 12:02 PM, Cosmin Tanislav wrote:  
> >>> Triggers exist under /sys/bus/iio/devices/, not under /sys/class/iio.
> >>> /sys/class/iio does not even exist. Use the current path.
> >>>
> >>> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> >>> ---
> >>>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> >>> index 5f87dcee78f7..4fc9f6bd4281 100644
> >>> --- a/Documentation/ABI/testing/sysfs-bus-iio
> >>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> >>> @@ -1428,7 +1428,7 @@ KernelVersion:	2.6.35
> >>>  Contact:	linux-iio@vger.kernel.org
> >>>  Description:
> >>>  		The name of the trigger source being used, as per string given
> >>> -		in /sys/class/iio/triggerY/name.
> >>> +		in /sys/bus/iio/devices/triggerY/name.  
> >>
> >> While we are fixing this, the docs refer to it as triggerX rather than
> >> triggerY.
> >>  
> > 
> > While I do agree that triggerX would match the definition inside
> > Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs, I think
> > triggerY is the correct name here, because iio:deviceX is used
> > right above. If we were to use triggerX, it would leave the
> > impression that the X from deviceX and the X from triggerX are the
> > same value.
> >   
> Fair point.
> 
Agreed and applied.

Thanks,

Jonathan

