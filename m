Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442383D9020;
	Tue, 26 May 2026 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798589; cv=none; b=eUpRFdwHfGhKe5B+lqQF+wrUFM7m2Y3FKSWV4pm4+NvMEyUXdL37Dlaa7yrqMWNcZY3GAEt5R/oMhuhmEoKEgrkofTUFmtXV1AnReoAWW5ErwlZd59yJPfgVuP8GX56NF2XLJNkjd9dx6qMqyWAUk6ZTlV++KZfF35axcjsLRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798589; c=relaxed/simple;
	bh=ft6YEOEK17g++V2pW9DIBhbX6s5uO6lIPyqPyzdYXKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnzODMjllCxey0nH8HFWQDqswOkZpZtkFEHoDvqYNvK1hq/LHn2R5Kik48qjg6w+eYhuNH3r7u6dL7L5WttkEtMVmNKsD05Y+hA8lZzdLfVQq41GDasLgFZ8vNwuTFXlmAcCqLEBfz9RS7E1mkqEkyggHCgeZSL3WkUcncM4Jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+rR01GT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+rR01GT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C5F1F000E9;
	Tue, 26 May 2026 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779798587;
	bh=oUNsGHdOmMSQXK0Lu7gexvE/BygIT4cqeMVi5MZV/4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i+rR01GTB536M7SDkkVuqMD9mOL9yBlQJihdQ2oIzdjispo8VIrdsDRN/GIUgCSZT
	 XaG7Vwc3/xYj0bsjzjAfU0GQsr2bmR1V/IZNSbivAO3OvAx43KGURpEvi3TF+GJpJd
	 9v97PiJQ3MKClrZuPT//wr9D+liW2Fm/3/AT/Jg0ElWho0bmJZXndQq5OxfxCxWJqA
	 rOBVL/hBhRyJ/Y97oMDrZEHEfrE6Bh5qQbt8o1kAforDsjCGIRPG8B0yndvNDEnMV4
	 C62NRJaIDxvzeUJyGiOLzgN7n0Y5K4Xsr7azbMCW8V1YiZG2fmCBuODM8cRP28OQlh
	 zDe00NXnh/7sQ==
Date: Tue, 26 May 2026 13:29:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V8 05/10] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <20260526132937.491f75af@jic23-huawei>
In-Reply-To: <PH0PR19MB99733838CE49A3752AAEA250ABA50F2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
	<20260518200526.458421-6-macroalpha82@gmail.com>
	<20260520181353.0a0371cb@jic23-huawei>
	<PH0PR19MB9973386EF146AD6590DE5508F5A50E2@PH0PR19MB997338.namprd19.prod.outlook.com>
	<20260522120515.652661ed@jic23-huawei>
	<PH0PR19MB99733838CE49A3752AAEA250ABA50F2@PH0PR19MB997338.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 11:23:59 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Fri, May 22, 2026 at 12:05:15PM +0100, Jonathan Cameron wrote:
> >   
> > > >     
> > > > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > > index e9c81b52f9ef..bc0cefa2fb77 100644
> > > > > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > > > @@ -9,6 +9,7 @@
> > > > >  #include <linux/irq.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/mutex.h>
> > > > > +#include <linux/pm_runtime.h>
> > > > >  #include <linux/property.h>
> > > > >  #include <linux/regmap.h>
> > > > >  #include <linux/regulator/consumer.h>
> > > > > @@ -72,6 +73,62 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
> > > > >  };
> > > > >  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
> > > > >  
> > > > > +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> > > > > +				      enum inv_icm42607_sensor_mode gyro,
> > > > > +				      enum inv_icm42607_sensor_mode accel,
> > > > > +				      bool temp, unsigned int *sleep_ms)
> > > > > +{
> > > > > +	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
> > > > > +	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
> > > > > +	bool oldtemp = st->conf.temp_en;
> > > > > +	unsigned int sleepval;
> > > > > +	unsigned int val;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
> > > > > +		return 0;
> > > > > +
> > > > > +	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
> > > > > +	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> > > > > +	if (!temp)
> > > > > +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> > > > > +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	st->conf.gyro.mode = gyro;
> > > > > +	st->conf.accel.mode = accel;
> > > > > +	st->conf.temp_en = temp;
> > > > > +
> > > > > +	sleepval = 0;
> > > > > +	if (temp && !oldtemp) {
> > > > > +		if (sleepval < INV_ICM42607_TEMP_STARTUP_TIME_MS)
> > > > > +			sleepval = INV_ICM42607_TEMP_STARTUP_TIME_MS;    
> > > > 		sleepval = max(sleepval,)
> > > > or just assign it here if not later patches add stuff in between
> > > > the assignment to 0 and here.    
> > Wow I write some garbage English sometimes (no excuse, it is my
> > native language!)   
> > > 
> > > I'm going to assign it to 0 here (unless you think I should define it
> > > at the beginning as 0) and then tweak as needed. I think this code
> > > here can be further optimized, especially if we make the assumption
> > > that START and STOP time for each sensor is comparable (the datasheet
> > > doesn't say, so I'm going to go with yes since that greatly simplifies
> > > things).  
> > 
> > I'm a bit lost. Suggestion was just to do
> > 		sleepval = INV_ICM42607_TEMP_STARTUP_TIME_MS;
> > as we know it is 0.   Probably not worth it though as ends up with fragile
> > code.  Fine to keep it to what you have but use max() rather than
> > if()
> > 
> > ...
> >   
> > > > > +static int inv_icm42607_resume(struct device *dev)
> > > > > +{
> > > > > +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> > > > > +	int ret;
> > > > > +
> > > > > +	guard(mutex)(&st->lock);
> > > > > +    
> > > > Given the bunch of stuff we've run into recently around these
> > > > I'm getting more paranoid.
> > > > Similar to above, could you use pm_runtime_force_resume()
> > > > You would need to gate stuff added later to not occur
> > > > though if it wasn't runtime suspended.    
> > > 
> > > This I'm having trouble understanding. If I use
> > > pm_force_runtime_resume() I'm assuming that either I got an error (in
> > > which case I'd return the error) or the device is runtime resumed
> > > after the call completes. If that's the case, wouldn't my suspend and
> > > resume steps just be pm_force_runtime_suspend/resume, and enabling the
> > > regulator (first for resume) or disabling the regulator (last for
> > > suspend) as needed?  
> > 
> > If you call pm_runtime_force_resume() it will do the right thing
> > wrt to runtime PM state prior to suspend.  If it wasn't runtime suspended
> > it will runtime resume - if it was it'll no do anything. It won't
> > directly tell you which one it did though.
> > 
> > The extra stuff that you know can't be the case if runtime pm is on
> > will need some sort of gating.  However, looking again it may already
> > be protected by more specific checks.
> > 
> > 
> > 	pm_runtime_force_resume();
> > 
> > 	if (st->fifo.on) { //I'd failed to look at what was added.
> > 		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
> > 				   INV_ICM42607_FIFO_CONFIG1_MODE);
> > 		if (ret)
> > 			return ret;
> > 	}
> > 
> > That if (st->fifo.on) previously didn't get checked if we were runtime
> > suspended because in fifo mode we never are.  So I was thinking you'd
> > need that check to be
> > 	if (!pm_runtime_suspended(dev) && st->fifo.on)
> > but the fifo.on check is sufficient by the same argument that if fifo.on
> > is true we aren't in runtime suspend.
> > 
> > Basically I overthought it and didn't check what got added where the
> > comment is in this patch.  
> 
> I'm still lost here... are you saying the existing logic is sufficient or
> that we need to do something more (like force the runtime resume/suspend
> in different places).

I'm saying you should call pm_runtime_force_resume() in the resume()
callback and the equivalent in the suspend() callback + call anything
extra that is done in those callbacks in appropriate order.

My original thought that some of the 'extra' stuff not covered by
pm_runtime_force...() would need extra gating but I think what you have
there is effectively the same via checks that happen to align with the
runtime resume / suspend states.

Jonathan

> 
> Thank you again for all of your help, you've been amazing.
> 
> Chris
> 
> > 
> >    
> > >   
> > > > 
> > > >     
> > > > > +	if (pm_runtime_suspended(dev))
> > > > > +		return 0;
> > > > > +
> > > > > +	ret = inv_icm42607_enable_vddio_reg(st);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	/* Nothing else to restore at this time. */
> > > > > +
> > > > > +	return 0;
> > > > > +}  
> >   

