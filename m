Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <55aace217d3212cc2662d5dd010c7e5c8c0e357d.1467123107.git.leonard.crestez@intel.com>
References: <55aace217d3212cc2662d5dd010c7e5c8c0e357d.1467123107.git.leonard.crestez@intel.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----QZSN4RLU888ABDT16H1K9T50TUHLT3"
Subject: Re: [PATCH] iio: Fix missing unlock on duplicate trigger
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 28 Jun 2016 17:20:03 +0100
To: Crestez Dan Leonard <leonard.crestez@intel.com>,Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org,Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Daniel Baluta <daniel.baluta@intel.com>
Message-ID: <960A05A3-9B6C-497D-A306-7961C7B5A04E@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

------QZSN4RLU888ABDT16H1K9T50TUHLT3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

I applied a fix doing it after the gone to label in the error path last night. Either is fine
 but as I want to get a pull request post auto builds out today will leave as is.

Thanks though!

J

On 28 June 2016 15:12:01 BST, Crestez Dan Leonard <leonard.crestez@intel.com> wrote:
>Since duplicate trigger names are supposed to cause errors at probe
>time
>anyway this issue is unlikely to affect anyone.
>
>Fixes commit 2e2b6a13f5f5119c36551c1ab99b85e0ad1a2105:
>iio: Refuse to register triggers with duplicate names
>
>Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
>---
> drivers/iio/industrialio-trigger.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iio/industrialio-trigger.c
>b/drivers/iio/industrialio-trigger.c
>index 0f03523..68466be 100644
>--- a/drivers/iio/industrialio-trigger.c
>+++ b/drivers/iio/industrialio-trigger.c
>@@ -89,6 +89,7 @@ int iio_trigger_register(struct iio_trigger
>*trig_info)
> 	/* Add to list of available triggers held by the IIO core */
> 	mutex_lock(&iio_trigger_list_lock);
> 	if (__iio_trigger_find_by_name(trig_info->name)) {
>+		mutex_unlock(&iio_trigger_list_lock);
> 		pr_err("Duplicate trigger name '%s'\n", trig_info->name);
> 		ret = -EEXIST;
> 		goto error_device_del;
>-- 
>2.7.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------QZSN4RLU888ABDT16H1K9T50TUHLT3
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body>I applied a fix doing it after the gone to label in the error path last night. Either is fine<br>
 but as I want to get a pull request post auto builds out today will leave as is.<br>
<br>
Thanks though!<br>
<br>
J<br><br><div class="gmail_quote">On 28 June 2016 15:12:01 BST, Crestez Dan Leonard &lt;leonard.crestez@intel.com&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class="k9mail">Since duplicate trigger names are supposed to cause errors at probe time<br />anyway this issue is unlikely to affect anyone.<br /><br />Fixes commit 2e2b6a13f5f5119c36551c1ab99b85e0ad1a2105:<br />iio: Refuse to register triggers with duplicate names<br /><br />Signed-off-by: Crestez Dan Leonard &lt;leonard.crestez@intel.com&gt;<br />---<br /> drivers/iio/industrialio-trigger.c | 1 +<br /> 1 file changed, 1 insertion(+)<br /><br />diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c<br />index 0f03523..68466be 100644<br />--- a/drivers/iio/industrialio-trigger.c<br />+++ b/drivers/iio/industrialio-trigger.c<br />@@ -89,6 +89,7 @@ int iio_trigger_register(struct iio_trigger *trig_info)<br />  /* Add to list of available triggers held by the IIO core */<br />  mutex_lock(&amp;iio_trigger_list_lock);<br />  if (__iio_trigger_find_by_name(trig_info-&gt;name)) {<br />+  mutex_unlock(&amp;iio_trigger_list_lock);<br />   pr_err("Du
 plicate
trigger name '%s'\n", trig_info-&gt;name);<br />   ret = -EEXIST;<br />   goto error_device_del;</pre></blockquote></div><br>
-- <br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.</body></html>
------QZSN4RLU888ABDT16H1K9T50TUHLT3--
