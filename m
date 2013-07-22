Return-Path: <jic23@kernel.org>
In-Reply-To: <1374142766-29736-1-git-send-email-x0199363@ti.com>
References: <1374142766-29736-1-git-send-email-x0199363@ti.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----O2S8OL2ARB3UMFK8QM552YU6WV885H"
Subject: Re: [PATCH 1/3] iio: core: implement devm_iio_device_alloc/devm_iio_device_free
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 22 Jul 2013 17:27:05 +0100
To: Oleksandr Kravchenko <x0199363@ti.com>,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org,linux-doc@vger.kernel.org
CC: grant.likely@linaro.org,rob.herring@calxeda.com,rob@landley.net,jic23@cam.ac.uk,pmeerw@pmeerw.net,holler@ahsoftware.de,srinivas.pandruvada@intel.com,devicetree-discuss@lists.ozlabs.org,grygorii.strashko@ti.com,Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Message-ID: <35a5c862-d56d-4230-a193-d19610c70dda@email.android.com>
List-ID: <linux-iio@vger.kernel.org>

------O2S8OL2ARB3UMFK8QM552YU6WV885H
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit

Just noticed that we need do document this in devres.txt....

Oleksandr Kravchenko <x0199363@ti.com> wrote:
>From: Grygorii Strashko <grygorii.strashko@ti.com>
>
>Add a resource managed devm_iio_device_alloc()/devm_iio_device_free()
>to automatically clean up any allocations made by IIO drivers,
>thus leading to simplified IIO drivers code.
>
>In addition, this will allow IIO drivers to use other devm_*() API
>(like devm_request_irq) and don't care about the race between
>iio_device_free() and the release of resources by Device core
>during driver removing.
>
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>[o.v.kravchenko@globallogic.com: fix return value ib
>devm_iio_device_alloc
>in case if devres_alloc failed, remove unused variable "rc"]
>Signed-off-by: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
>Tested-by: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
>---
>drivers/iio/industrialio-core.c |   47
>+++++++++++++++++++++++++++++++++++++++
> include/linux/iio/iio.h         |   25 +++++++++++++++++++++
> 2 files changed, 72 insertions(+)
>
>diff --git a/drivers/iio/industrialio-core.c
>b/drivers/iio/industrialio-core.c
>index e145931..d56d122 100644
>--- a/drivers/iio/industrialio-core.c
>+++ b/drivers/iio/industrialio-core.c
>@@ -912,6 +912,53 @@ void iio_device_free(struct iio_dev *dev)
> }
> EXPORT_SYMBOL(iio_device_free);
> 
>+static void devm_iio_device_release(struct device *dev, void *res)
>+{
>+	iio_device_free(*(struct iio_dev **)res);
>+}
>+
>+static int devm_iio_device_match(struct device *dev, void *res, void
>*data)
>+{
>+	struct iio_dev **r = res;
>+	if (!r || !*r) {
>+		WARN_ON(!r || !*r);
>+		return 0;
>+	}
>+	return *r == data;
>+}
>+
>+struct iio_dev *devm_iio_device_alloc(struct device *dev, int
>sizeof_priv)
>+{
>+	struct iio_dev **ptr, *iio_dev;
>+
>+	ptr = devres_alloc(devm_iio_device_release, sizeof(*ptr),
>+			   GFP_KERNEL);
>+	if (!ptr)
>+		return NULL;
>+
>+	/* use raw alloc_dr for kmalloc caller tracing */
>+	iio_dev = iio_device_alloc(sizeof_priv);
>+	if (iio_dev) {
>+		*ptr = iio_dev;
>+		devres_add(dev, ptr);
>+	} else {
>+		devres_free(ptr);
>+	}
>+
>+	return iio_dev;
>+}
>+EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
>+
>+void devm_iio_device_free(struct device *dev, struct iio_dev *iio_dev)
>+{
>+	int rc;
>+
>+	rc = devres_release(dev, devm_iio_device_release,
>+			    devm_iio_device_match, iio_dev);
>+	WARN_ON(rc);
>+}
>+EXPORT_SYMBOL_GPL(devm_iio_device_free);
>+
> /**
>  * iio_chrdev_open() - chrdev file open for buffer access and ioctls
>  **/
>diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>index 8d171f4..f1d99f6 100644
>--- a/include/linux/iio/iio.h
>+++ b/include/linux/iio/iio.h
>@@ -532,6 +532,31 @@ static inline struct iio_dev *iio_priv_to_dev(void
>*priv)
> void iio_device_free(struct iio_dev *indio_dev);
> 
> /**
>+ * devm_iio_device_alloc - Resource-managed iio_device_alloc()
>+ * @dev: 		Device to allocate iio_dev for
>+ * @sizeof_priv: 	Space to allocate for private structure.
>+ *
>+ * Managed iio_device_alloc.  iio_dev allocated with this function is
>+ * automatically freed on driver detach.
>+ *
>+ * If an iio_dev allocated with this function needs to be freed
>separately,
>+ * devm_iio_device_free() must be used.
>+ *
>+ * RETURNS:
>+ * Pointer to allocated iio_dev on success, NULL on failure.
>+ */
>+struct iio_dev *devm_iio_device_alloc(struct device *dev, int
>sizeof_priv);
>+
>+/**
>+ * devm_iio_device_free - Resource-managed iio_device_free()
>+ * @dev:		Device this iio_dev belongs to
>+ * @indio_dev: 		the iio_dev associated with the device
>+ *
>+ * Free indio_dev allocated with devm_iio_device_alloc().
>+ */
>+void devm_iio_device_free(struct device *dev, struct iio_dev
>*iio_dev);
>+
>+/**
>* iio_buffer_enabled() - helper function to test if the buffer is
>enabled
>  * @indio_dev:		IIO device structure for device
>  **/
>-- 
>1.7.9.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
------O2S8OL2ARB3UMFK8QM552YU6WV885H
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body>Just noticed that we need do document this in devres.txt....<br><br><div class="gmail_quote">Oleksandr Kravchenko &lt;x0199363@ti.com&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class="k9mail">From: Grygorii Strashko &lt;grygorii.strashko@ti.com&gt;<br /><br />Add a resource managed devm_iio_device_alloc()/devm_iio_device_free()<br />to automatically clean up any allocations made by IIO drivers,<br />thus leading to simplified IIO drivers code.<br /><br />In addition, this will allow IIO drivers to use other devm_*() API<br />(like devm_request_irq) and don't care about the race between<br />iio_device_free() and the release of resources by Device core<br />during driver removing.<br /><br />Signed-off-by: Grygorii Strashko &lt;grygorii.strashko@ti.com&gt;<br />[o.v.kravchenko@globallogic.com: fix return value ib devm_iio_device_alloc<br />in case if devres_alloc failed, remove unused variable "rc"]<br />Signed-off-by: Oleksandr Kravchenko &lt;o.v.kravchenko@globallogic.com&gt;<br />Tested-by: Oleksandr Kravchenko &lt;o.v.kravchenko@globallogic.com&gt;<br />---<br />drivers/iio/industrialio-core.c |   47 +++++++++++++++++++++++++++++++++++++++<br
/>include/linux/iio/iio.h         |   25 +++++++++++++++++++++<br />2 files changed, 72 insertions(+)<br /><br />diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c<br />index e145931..d56d122 100644<br />--- a/drivers/iio/industrialio-core.c<br />+++ b/drivers/iio/industrialio-core.c<br />@@ -912,6 +912,53 @@ void iio_device_free(struct iio_dev *dev)<br />}<br />EXPORT_SYMBOL(iio_device_free);<br /><br />+static void devm_iio_device_release(struct device *dev, void *res)<br />+{<br />+ iio_device_free(*(struct iio_dev **)res);<br />+}<br />+<br />+static int devm_iio_device_match(struct device *dev, void *res, void *data)<br />+{<br />+ struct iio_dev **r = res;<br />+ if (!r || !*r) {<br />+  WARN_ON(!r || !*r);<br />+  return 0;<br />+ }<br />+ return *r == data;<br />+}<br />+<br />+struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)<br />+{<br />+ struct iio_dev **ptr, *iio_dev;<br />+<br />+ ptr =
devres_alloc(devm_iio_device_release, sizeof(*ptr),<br />+      GFP_KERNEL);<br />+ if (!ptr)<br />+  return NULL;<br />+<br />+ /* use raw alloc_dr for kmalloc caller tracing */<br />+ iio_dev = iio_device_alloc(sizeof_priv);<br />+ if (iio_dev) {<br />+  *ptr = iio_dev;<br />+  devres_add(dev, ptr);<br />+ } else {<br />+  devres_free(ptr);<br />+ }<br />+<br />+ return iio_dev;<br />+}<br />+EXPORT_SYMBOL_GPL(devm_iio_device_alloc);<br />+<br />+void devm_iio_device_free(struct device *dev, struct iio_dev *iio_dev)<br />+{<br />+ int rc;<br />+<br />+ rc = devres_release(dev, devm_iio_device_release,<br />+       devm_iio_device_match, iio_dev);<br />+ WARN_ON(rc);<br />+}<br />+EXPORT_SYMBOL_GPL(devm_iio_device_free);<br />+<br />/**<br />* iio_chrdev_open() - chrdev file open for buffer access and ioctls<br />**/<br />diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h<br />index 8d171f4..f1d99f6 100644<br />--- a/include/linux/iio/iio.h<br />+++
b/include/linux/iio/iio.h<br />@@ -532,6 +532,31 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)<br />void iio_device_free(struct iio_dev *indio_dev);<br /><br />/**<br />+ * devm_iio_device_alloc - Resource-managed iio_device_alloc()<br />+ * @dev:   Device to allocate iio_dev for<br />+ * @sizeof_priv:  Space to allocate for private structure.<br />+ *<br />+ * Managed iio_device_alloc.  iio_dev allocated with this function is<br />+ * automatically freed on driver detach.<br />+ *<br />+ * If an iio_dev allocated with this function needs to be freed separately,<br />+ * devm_iio_device_free() must be used.<br />+ *<br />+ * RETURNS:<br />+ * Pointer to allocated iio_dev on success, NULL on failure.<br />+ */<br />+struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);<br />+<br />+/**<br />+ * devm_iio_device_free - Resource-managed iio_device_free()<br />+ * @dev:  Device this iio_dev belongs to<br />+ * @indio_dev:   the iio_dev associated with
the device<br />+ *<br />+ * Free indio_dev allocated with devm_iio_device_alloc().<br />+ */<br />+void devm_iio_device_free(struct device *dev, struct iio_dev *iio_dev);<br />+<br />+/**<br />* iio_buffer_enabled() - helper function to test if the buffer is enabled<br />* @indio_dev:  IIO device structure for device<br />**/</pre></blockquote></div><br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.</body></html>
------O2S8OL2ARB3UMFK8QM552YU6WV885H--
