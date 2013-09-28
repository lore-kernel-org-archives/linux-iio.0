Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41579 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab3I1Jvl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:51:41 -0400
Message-ID: <5246B4D5.4000103@kernel.org>
Date: Sat, 28 Sep 2013 11:52:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: hennerich@blackfin.uclinux.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:trigger: fix sysfs name on list mutex
References: <1379933351-27498-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1379933351-27498-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/23/13 11:49, Denis CIOCCA wrote:
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git

Thanks for cleaning this up.
> ---
>  drivers/iio/trigger/iio-trig-sysfs.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> index effcd0a..15e3b85 100644
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -23,7 +23,7 @@ struct iio_sysfs_trig {
>  };
>  
>  static LIST_HEAD(iio_sysfs_trig_list);
> -static DEFINE_MUTEX(iio_syfs_trig_list_mut);
> +static DEFINE_MUTEX(iio_sysfs_trig_list_mut);
>  
>  static int iio_sysfs_trigger_probe(int id);
>  static ssize_t iio_sysfs_trig_add(struct device *dev,
> @@ -135,7 +135,7 @@ static int iio_sysfs_trigger_probe(int id)
>  	struct iio_sysfs_trig *t;
>  	int ret;
>  	bool foundit = false;
> -	mutex_lock(&iio_syfs_trig_list_mut);
> +	mutex_lock(&iio_sysfs_trig_list_mut);
>  	list_for_each_entry(t, &iio_sysfs_trig_list, l)
>  		if (id == t->id) {
>  			foundit = true;
> @@ -169,7 +169,7 @@ static int iio_sysfs_trigger_probe(int id)
>  		goto out2;
>  	list_add(&t->l, &iio_sysfs_trig_list);
>  	__module_get(THIS_MODULE);
> -	mutex_unlock(&iio_syfs_trig_list_mut);
> +	mutex_unlock(&iio_sysfs_trig_list_mut);
>  	return 0;
>  
>  out2:
> @@ -177,7 +177,7 @@ out2:
>  free_t:
>  	kfree(t);
>  out1:
> -	mutex_unlock(&iio_syfs_trig_list_mut);
> +	mutex_unlock(&iio_sysfs_trig_list_mut);
>  	return ret;
>  }
>  
> @@ -185,14 +185,14 @@ static int iio_sysfs_trigger_remove(int id)
>  {
>  	bool foundit = false;
>  	struct iio_sysfs_trig *t;
> -	mutex_lock(&iio_syfs_trig_list_mut);
> +	mutex_lock(&iio_sysfs_trig_list_mut);
>  	list_for_each_entry(t, &iio_sysfs_trig_list, l)
>  		if (id == t->id) {
>  			foundit = true;
>  			break;
>  		}
>  	if (!foundit) {
> -		mutex_unlock(&iio_syfs_trig_list_mut);
> +		mutex_unlock(&iio_sysfs_trig_list_mut);
>  		return -EINVAL;
>  	}
>  
> @@ -202,7 +202,7 @@ static int iio_sysfs_trigger_remove(int id)
>  	list_del(&t->l);
>  	kfree(t);
>  	module_put(THIS_MODULE);
> -	mutex_unlock(&iio_syfs_trig_list_mut);
> +	mutex_unlock(&iio_sysfs_trig_list_mut);
>  	return 0;
>  }
>  
> 
