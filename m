Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 23 Jul 2013 14:26:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jingoo Han <jg1.han@samsung.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Cc: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/2] staging: iio: replace strict_strto*() with kstrto*()
Message-ID: <20130723112655.GR5585@mwanda>
References: <001d01ce878e$0e76b710$2b642530$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001d01ce878e$0e76b710$2b642530$@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 23, 2013 at 07:19:03PM +0900, Jingoo Han wrote:
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index 38a158b..03766bb 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -87,7 +87,7 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
>  	bool enabled;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &val);
> +	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  

Btw, this function is not beautiful.

drivers/staging/iio/trigger/iio-trig-bfin-timer.c
    81  static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
    82                  struct device_attribute *attr, const char *buf, size_t count)
    83  {
    84          struct iio_trigger *trig = to_iio_trigger(dev);
    85          struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
    86          unsigned long val;
    87          bool enabled;
    88          int ret;
    89  
    90          ret = strict_strtoul(buf, 10, &val);
    91          if (ret)
    92                  goto error_ret;

I have updated CodingStyle to reflect that we are encouraged to
return directly here instead of doing bogus gotos which imply
error handly but in fact do nothing at all.

    93  
    94          if (val > 100000) {
    95                  ret = -EINVAL;
    96                  goto error_ret;
    97          }
    98  
    99          enabled = get_enabled_gptimers() & st->t->bit;
   100  
   101          if (enabled)
   102                  disable_gptimers(st->t->bit);
   103  
   104          if (!val)
   105                  goto error_ret;

So at this point we have disabled disable_gptimers().  The goto is
called "error_ret" which says "error" but actually we are returning
success.  It's easy to imagine that "val == 0" is invalid because
that would cause a divide by zero.  But on the other hand maybe zero
has a special meaning which is that we should disable gptimers and
return success?

If the code said:

	if (enabled)
		disable_gptimers(st->t->bit);
	if (val == 0)
		return count;
	[---blank line---]
	val = get_sclk() / val;

That would be totally clear what was intended.

   106  
   107          val = get_sclk() / val;
   108          if (val <= 4 || val <= st->duty) {
   109                  ret = -EINVAL;
   110                  goto error_ret;

I'm pretty sure this is a bug.  We want to enable gptimers if "val"
is totally invalid.

   111          }
   112  
   113          set_gptimer_period(st->t->id, val);
   114          set_gptimer_pwidth(st->t->id, val - st->duty);
   115  
   116          if (enabled)
   117                  enable_gptimers(st->t->bit);
   118  
   119  error_ret:
   120          return ret ? ret : count;
   121  }

regards,
dan carpenter
