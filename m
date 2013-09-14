Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39518 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293Ab3INJhp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:37:45 -0400
Message-ID: <52343C86.8040109@kernel.org>
Date: Sat, 14 Sep 2013 11:37:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: iio: tsl2x7x_core: Remove redundant break
References: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org> <1378894829-8173-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378894829-8173-5-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 11:20, Sachin Kamat wrote:
> 'break' after return is redundant. Remove it.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c |    8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index 3439d37..9c43dcf 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -951,7 +951,6 @@ static ssize_t tsl2x7x_gain_available_show(struct device *dev,
>  	case tsl2771:
>  	case tmd2771:
>  		return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 128");
> -	break;
>  	}
>  
>  	return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
> @@ -1346,7 +1345,6 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -			break;
>  		}
>  		break;
>  	case IIO_CHAN_INFO_RAW:
> @@ -1366,7 +1364,6 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  			break;
>  		default:
>  			return -EINVAL;
> -			break;
>  		}
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
> @@ -1419,7 +1416,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  				case tsl2772:
>  				case tmd2772:
>  					return -EINVAL;
> -				break;
>  				}
>  				chip->tsl2x7x_settings.als_gain = 3;
>  				break;
> @@ -1431,7 +1427,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  				case tsl2771:
>  				case tmd2771:
>  					return -EINVAL;
> -				break;
>  				}
>  				chip->tsl2x7x_settings.als_gain = 3;
>  				break;
> @@ -1508,18 +1503,15 @@ static int tsl2x7x_device_id(unsigned char *id, int target)
>  	case tsl2671:
>  	case tsl2771:
>  		return ((*id & 0xf0) == TRITON_ID);
> -	break;
>  	case tmd2671:
>  	case tmd2771:
>  		return ((*id & 0xf0) == HALIBUT_ID);
> -	break;
>  	case tsl2572:
>  	case tsl2672:
>  	case tmd2672:
>  	case tsl2772:
>  	case tmd2772:
>  		return ((*id & 0xf0) == SWORDFISH_ID);
> -	break;
>  	}
>  
>  	return -EINVAL;
> 
