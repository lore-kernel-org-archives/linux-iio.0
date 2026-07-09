Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A143079D
	for <linux-iio@vger.kernel.org>; Thu,  9 Jul 2026 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613244; cv=none; b=gBVlCXmAbCkVlAj1qUUou6pTVYPKh8/msaYD8y1e8NtgUJxTIVOABaD5jQz3OF3zjmmqBLGqOokJ9jNHokKRZ/yNCZVoZHMGK3y+zWDlaLaS9IWcfH3mLC3nbgZs5zMWGPB/MqXMW8CyLIWyXXrUBMF9fxrESk3XORSS0bn66wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613244; c=relaxed/simple;
	bh=TfiHSLMBjZ80AM2O04NWCaLK29aZWfR88RfiqOuVlcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDHC7HHReLU8NmmWvWE3WmWvkszzyWO2AhCyim2iW+eGoxh7I2oQhcCf5GTufSRL2LXPZkhDfZrqhnFSh6wtUftrbWjdrlq+tdo5HmcsvZOSe0QFtOL2G5jzEyp8z9jm4NqftHtB6CDzU2ZpyyMue7XHGDSX3BgfdJuV1LvWHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBDFzVUC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBDFzVUC"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1987649b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 09 Jul 2026 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783613243; x=1784218043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ysgGA9FNs2LC6p8SRgBycN6NLmY0OUHVJV77+UK20Sc=;
        b=cBDFzVUCfbVwT+blU5hStVzsUa9sb8BUQReUAD95t+v/joFsWgfLfXi/KIYxD8YffC
         G44nohEBHc4A/nR7D7lCwVu7n7m6GnBUohblqBMtnNboRz9jv1s3T8fqiNn0YFZSb8Ei
         GU6IEyMzABSKWr4Ez79eNWQhkEsGMiYNZMzFIp5S/zi2DtL5fYYZ0Gt5+yUI30u63f8P
         LT3Rbbx/a38OCfPOodVXurkG7rdcLGcZNX4Rn59NbE/aP/hB3OCL7Dc6xvPuPMNgplfq
         wVWIlSkYSqo5m2elj56+rgscbhddEMk5vloWmpLVBaZ54LgZb3Vo765+eLawjm4pdJbY
         Shkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783613243; x=1784218043;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysgGA9FNs2LC6p8SRgBycN6NLmY0OUHVJV77+UK20Sc=;
        b=Ocegf3Y2RygJDWtrHV6PkMNN8wwu8+t5yXW76ZpqmhnvMpEJZMuZCAYeYrw4Kwa2C9
         tPflLfekhnyySdZBvyJSDFa5X/S47o92lqArkZ7Fyi0movst+TRsHa6HIreBRlRIisF+
         9kWBNcYJF7ZONzlns7z5C8v953QKU8LuA4PLKRzB0Hf2hGrZnRMbRhSFTYtK1YK34AEn
         N49iqPZyI7Kr7t2lBq6mTNoaAhv6Ou0pMRUmhlC/OIN7Is84pUgX3szOzlkc59OSjxTn
         goH5eNltwuYmvS51ZBnDVwKwRUmJn4OCbCmLeU+aMoWNDS0zL2coSjcMB/5RYxJoHroF
         tT8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoOBlpbPaw1mYwTXg6Zvxn2ynhvZQ3NnIWX9farDLcVqEpcRni4CJpB9O5/T1PtAP4yWfgt5dVU0EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTmX0b3hfcoQGATmjVrAt7bYlXvxGIC7N0PwD0/DfDKLQzg5r
	rF1qWz4w5DIh6kKJR0j6u6TTIejOlrv0uaksMuDW6ZKrf4hetirpMzxt
X-Gm-Gg: AfdE7cn2XQ7wP+OpaNH4y3jQn0qe3zPMK8Rij9FDZTNLf5lP4JwCFYm8/Ot1I5+vmY8
	vcd+rgWWlm1hO5hRE5icbzzUuvWoT0xKRIldbw+HvJoFwpqCVlH6QEpDFSHZF5Z6Nv8hlPQOBtH
	vsiKGpFRXms0ed+RNGVKIdZffth3/YBg7VlM0jkZANCZkwKDrPea5xzUQHE+rU56fbXeKpCGc/8
	t9BDHW9OFXnak42vVTurAPBoJoiGZlw5xcmDTI6es7PN7SvkFV5L5eo+3c9GxOUaQ2b+CD7wa7H
	OZUe8ne8DY/73c0soyv8IS01rU1ltVDIDG7TNaSAY0lHz5PcVmQ8jc1lD83YUZLbtOfACc3SapA
	AnE3vB9KBwXnt/Q79jo4UOSW7jKYLzhbnKr7CzGwZ5/0Qitt/ClpncHbnAv2nIv4Y/BxlXIcnnx
	u5xiVuozUHt3hObp2fhQ2j+moXPw==
X-Received: by 2002:a05:6a00:91a9:b0:848:44d2:72a2 with SMTP id d2e1a72fcca58-84844d2940fmr6740302b3a.27.1783613242449;
        Thu, 09 Jul 2026 09:07:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484d465991sm2206257b3a.47.2026.07.09.09.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:07:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 9 Jul 2026 09:07:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com,
	vincent.guittot@linaro.org, Souvik.Chakravarty@arm.com,
	Alex Shi <alexs@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	David Lechner <dlechner@baylibre.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Pavel Machek <pavel@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yanteng Si <si.yanteng@linux.dev>, arm-scmi@vger.kernel.org,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:ENERGY MODEL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH] firmware: scmi: Make SCMI arch independent
Message-ID: <6cc90547-a3d6-40b4-8914-a1ff60944cdf@roeck-us.net>
References: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>

On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
> On heterogenious systems like AMD/Xilinx FPGA there is a need to talk to
> SCMI server from different architectures than ARM that's why remove
> ARM/ARM64 Kconfig dependency with also remove ARM from description and
> rename folder to reflect it.
> From specification perspective only ARM specific transport layers should be
> available on ARM/ARM64 architectures.
> 
> That's why get rid of ARM prefix and description from documentation, file
> names, folder names, MODULE description, module names, Kconfig and
> comments.
> But keep origin Kconfig symbols not to break existing users.
> 
> Hwmon, pinctrl, powercap, regulator, reset, clk and cpufreq scmi drivers
> already miss arm prefix that's why synchronize all of them to be without
> arm prefix.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Likely I missed other locations but I wanted to send this RFC to have a
> discussion about it.
> ---
...
>  drivers/hwmon/Kconfig                                 |  2 +-
...
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2bfbcc033d59..cda0aedb36ca 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -401,7 +401,7 @@ config SENSORS_ARCTIC_FAN_CONTROLLER
>  	  will be called arctic_fan_controller.
>  
>  config SENSORS_ARM_SCMI
> -	tristate "ARM SCMI Sensors"
> +	tristate "SCMI Sensors"
>  	depends on ARM_SCMI_PROTOCOL
>  	depends on THERMAL || !THERMAL_OF
>  	help

I agree in principle, but I don't see why this would have to be done
in a single patch. Also, both the Kconfig file (SENSORS_ARM_SCMI,
ARM_SCMI_PROTOCOL) and the driver itself (""ARM SCMI HWMON interface
driver") still reference ARM.

Thanks,
Guenter
