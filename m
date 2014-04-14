Return-Path: <joe@perches.com>
Message-ID: <1397449975.5243.9.camel@joe-AO722>
Subject: Re: [Patch v4 1/6] devres: introduce API "devm_kmemdup
From: Joe Perches <joe@perches.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 13 Apr 2014 21:32:55 -0700
In-Reply-To: <1397449647-31708-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: 
	<1397449647-31708-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2014-04-13 at 21:27 -0700, Srinivas Pandruvada wrote:
> Introduce devm_kmemdup, which uses resource managed kmalloc.
> There are several request from maintainers to add this instead
> of using kmemdup.
[]
> diff --git a/include/linux/device.h b/include/linux/device.h
[]
> @@ -629,6 +629,8 @@ static inline void *devm_kcalloc(struct device *dev,
>  }
>  extern void devm_kfree(struct device *dev, void *p);
>  extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
> +extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
> +				gfp_t gfp);

Please align the arguments to the open parenthesis.
